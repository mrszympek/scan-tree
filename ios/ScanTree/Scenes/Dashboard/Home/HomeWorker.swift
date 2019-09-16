//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import Apollo

class HomeWorker {
    
    func fetchProducts(completion: @escaping FetchResultCompletion<[ProductDetails]>) {
        let query = AllProductsQuery()
        Apollo.shared.client.fetch(query: query) { (result) in
            switch result {
            case .success(let allProducts):
                guard let products = allProducts.data?.products else {
                    return
                }
                let productsToShow = products.compactMap({ (product) -> ProductDetails? in
                    return product?.fragments.productDetails
                })
                completion(.success(productsToShow))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
