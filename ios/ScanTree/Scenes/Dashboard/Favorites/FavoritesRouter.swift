//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesRoutingLogic: Router {
    func navigateToProductDetails()
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing {
    @objc weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?

    // MARK: Routing
    
    @objc func routeToProductDetails(withSegue segue: UIStoryboardSegue?) {
        guard let destinationVC = segue?.destination as? ProductDetailsViewController,
            var destinationDS = destinationVC.router?.dataStore,
            let dataStore = dataStore else {
                return
        }
        passDataToProductDetails(sourceDS: dataStore, destinationDS: &destinationDS)
    }

    // MARK: Navigation
    
    func navigateToProductDetails() {
        viewController?.performSegue(withIdentifier: "ProductDetails", sender: nil)
    }

    // MARK: Passing data

    func passDataToProductDetails(sourceDS: FavoritesDataStore, destinationDS: inout ProductDetailsDataStore) {
        destinationDS.selectedProduct = sourceDS.selectedProduct
    }

}
