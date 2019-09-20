//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesBusinessLogic {
    func fetchProducts()
    func search(withQuery query: String)
    func assignProduct(with identifier: String)
}

protocol FavoritesDataStore {
    var selectedProduct: ProductDetails? { get set }
}

class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    var presenter: FavoritesPresentationLogic?
    let worker = FavoritesWorker()
    
    var selectedProduct: ProductDetails?

    private var products: [ProductDetails] = []
    
    // MARK: Bussines logic
    
    func fetchProducts() {
        products = worker.fetchProducts()
        presenter?.presentFetchProductsSuccess(products)
    }
    
    func search(withQuery query: String) {
        var productsToShow: [ProductDetails]
        if query.isEmpty {
            productsToShow = products
        } else {
            productsToShow = products.filter({ $0.name.localizedCaseInsensitiveContains(query) })
        }
        presenter?.presentFetchProductsSuccess(productsToShow)
    }
    
    func assignProduct(with identifier: String) {
        guard let product = products.first(where: { $0.id == identifier }) else {
            log.error("Unable to find product with id: \(identifier)")
            return
        }
        selectedProduct = product
        presenter?.presentProductDetails()
    }
    
}
