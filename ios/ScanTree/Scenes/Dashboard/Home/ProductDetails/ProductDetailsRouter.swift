//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol ProductDetailsRoutingLogic: Router {
}

protocol ProductDetailsDataPassing {
    var dataStore: ProductDetailsDataStore? { get }
}

class ProductDetailsRouter: NSObject, ProductDetailsRoutingLogic, ProductDetailsDataPassing {
    @objc weak var viewController: ProductDetailsViewController?
    var dataStore: ProductDetailsDataStore?

    // MARK: Routing

    // MARK: Navigation

    // MARK: Passing data

}
