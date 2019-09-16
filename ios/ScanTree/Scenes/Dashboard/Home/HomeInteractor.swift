//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol HomeBusinessLogic {
    func fetchProducts()
    func search(withQuery query: String)
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    let worker = HomeWorker()
    
    private var products: [ProductDetails] = []

    // MARK: Bussines logic
    
    func fetchProducts() {
        worker.fetchProducts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.presenter?.presentFetchProductsSuccess(products)
            case .failure(let error):
                self.presenter?.presentFetchProductsError(error: error)
            }
        }
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
    
}
