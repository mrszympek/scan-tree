//
//  DatabaseWorker.swift
//  ScanTree
//
//  Created by Kamil Zajac on 16/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation

import CoreData

final class DatabaseWorker {
    
    static let sharedInstance = DatabaseWorker()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ScanTree")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var mainManagedObjectContext: NSManagedObjectContext = {
        let coordinator = persistentContainer.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let coordinator = persistentContainer.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func clearWholeDatabase() {
        let context = backgroundContext
        let productRequest: NSFetchRequest<ProductManagedObject> = ProductManagedObject.fetchRequest()
        do {
            try context.fetch(productRequest).forEach { context.delete($0) }
            try context.save()
            log.info("Removed all products")
        } catch {
            log.error("Clearing database removing error: \(error.localizedDescription)")
        }
    }
    
}
