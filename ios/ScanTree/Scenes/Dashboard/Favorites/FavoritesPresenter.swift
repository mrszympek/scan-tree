//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesPresentationLogic {
    func presentFetchProductsSuccess(_ products: [ProductDetails])
    func presentProductDetails()
}

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic?
    
    func presentFetchProductsSuccess(_ products: [ProductDetails]) {
        let viewModels = products.map { (product) -> Home.List.ViewModel in
            return Home.List.ViewModel(
                id: product.id,
                name: "\(product.name)",
                description: product.description,
                price: "Price: \(product.price) zł",
                latinName: product.latinName,
                category: "Category: \(product.category)",
                variety: product.variety,
                createdDate: product.createDate,
                image: product.image
            )
        }
        viewController?.displayFetchProductsSuccess(viewModels)
    }
    
    func presentProductDetails() {
        viewController?.displayProductDetails()
    }
    
}
