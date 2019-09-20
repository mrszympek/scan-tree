//
//  ProductManagedObject+CoreDataClass.swift
//  ScanTree
//
//  Created by Kamil Zajac on 16/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ProductManagedObject)
public class ProductManagedObject: NSManagedObject {

}

extension ProductManagedObject {
    
    public convenience init(from product: ProductDetails) {
        let context = DatabaseWorker.sharedInstance.backgroundContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductManagedObject", in: context)!
        self.init(entity: entity, insertInto: context)
        id = product.id
        name = product.name
        price = Double(product.price)
        desc = product.description
        latinName = product.latinName
        category = product.category
        variety = product.variety
        createdDate = product.createDate
        image = product.image
    }
    
}
