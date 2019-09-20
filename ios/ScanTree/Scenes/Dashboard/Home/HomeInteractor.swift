//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import Apollo

protocol HomeBusinessLogic {
    func fetchProducts()
    func search(withQuery query: String)
    func assignProduct(with identifier: String)
}

protocol HomeDataStore {
    var selectedProduct: ProductDetails? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    let worker = HomeWorker()
    
    var selectedProduct: ProductDetails?
    
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
    
    func assignProduct(with identifier: String) {
        guard let product = products.first(where: { $0.id == identifier }) else {
            log.error("Unable to find product with id: \(identifier)")
            presenter?.presentUnableToFindProduct(error: "Unable to find product for scanned QR code")
            return
        }
        selectedProduct = product
        presenter?.presentProductDetails()
    }
    
}
