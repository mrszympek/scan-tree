//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol ProductDetailsBusinessLogic {
    func setupViewWithData()
    func markAsFavorite()
}

protocol ProductDetailsDataStore {
    var selectedProduct: ProductDetails? { get set }
}

class ProductDetailsInteractor: ProductDetailsBusinessLogic, ProductDetailsDataStore {
    var presenter: ProductDetailsPresentationLogic?
    let worker = ProductDetailsWorker()
    
    var selectedProduct: ProductDetails?

    // MARK: Bussines logic
    
    func setupViewWithData() {
        guard let product = selectedProduct else {
            log.error("Product wasn't passed")
            return
        }
        let isFavorite = worker.isFavorite(product)
        presenter?.presentProductDetails(product, isFavorite: isFavorite)
    }
    
    func markAsFavorite() {
        guard let product = selectedProduct else { return }
        worker.saveFavoriteProduct(product)
        let isFavorite = worker.isFavorite(product)
        presenter?.presentProductDetails(product, isFavorite: isFavorite)
    }
    
}
