//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import CoreData

class ProductDetailsWorker {
    
    private let backgroundContext = DatabaseWorker.sharedInstance.backgroundContext
    
    func saveFavoriteProduct(_ product: ProductDetails) {
        let fetchRequest: NSFetchRequest<ProductManagedObject> = ProductManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)
        do {
            if let productMO = try backgroundContext.fetch(fetchRequest).first {
                log.info("Remove product from favorites")
                backgroundContext.delete(productMO)
                try backgroundContext.save()
            } else {
                log.info("Add product to favorites")
                let _ = ProductManagedObject(from: product)
                try backgroundContext.save()
            }
        } catch {
            log.error("Unable to save favorite product in database")
        }
    }
    
    func isFavorite(_ product: ProductDetails) -> Bool {
        let fetchRequest: NSFetchRequest<ProductManagedObject> = ProductManagedObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id)
        do {
            let productMO = try backgroundContext.fetch(fetchRequest).first
            return productMO != nil
        } catch {
            return false
        }
    }
    
}
