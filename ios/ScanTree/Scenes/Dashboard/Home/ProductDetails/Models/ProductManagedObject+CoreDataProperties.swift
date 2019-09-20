//
//  ProductManagedObject+CoreDataProperties.swift
//  ScanTree
//
//  Created by Kamil Zajac on 16/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//
//

import Foundation
import CoreData


extension ProductManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductManagedObject> {
        return NSFetchRequest<ProductManagedObject>(entityName: "ProductManagedObject")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var desc: String
    @NSManaged public var price: Double
    @NSManaged public var latinName: String
    @NSManaged public var category: String
    @NSManaged public var variety: String
    @NSManaged public var createdDate: String
    @NSManaged public var image: String

}
