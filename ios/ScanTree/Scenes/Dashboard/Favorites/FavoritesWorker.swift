//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import CoreData

class FavoritesWorker {
    
    func fetchProducts() -> [ProductDetails] {
        let backgroundContext = DatabaseWorker.sharedInstance.backgroundContext
        let fetchRequest: NSFetchRequest<ProductManagedObject> = ProductManagedObject.fetchRequest()
        do {
            return try backgroundContext.fetch(fetchRequest).map({
                ProductDetails(
                    id: $0.id,
                    name: $0.name,
                    description: $0.desc,
                    price: $0.price,
                    latinName: $0.latinName,
                    category: $0.category,
                    variety: $0.variety,
                    createDate: $0.createdDate,
                    image: $0.image
                )
            })
        } catch {
            log.error("Unable to fetch products from database")
            return []
        }
    }
    
}
