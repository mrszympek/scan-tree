//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol HomePresentationLogic {
    func presentFetchProductsSuccess(_ products: [ProductDetails])
    func presentFetchProductsError(error: Error)
    func presentUnableToFindProduct(error: String)
    func presentProductDetails()
}

class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    
    func presentFetchProductsError(error: Error) {
        viewController?.displayFetchProductsError(error: error.localizedDescription)
    }
    
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
                createdDate: product.createDate
            )
        }
        viewController?.displayFetchProductsSuccess(viewModels)
    }
    
    func presentProductDetails() {
        viewController?.displayProductDetails()
    }
    
    func presentUnableToFindProduct(error: String) {
        viewController?.displayUnableToFindProduct(error: error)
    }
    
}
