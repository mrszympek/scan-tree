//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol HomeRoutingLogic: Router {
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    @objc weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    // MARK: Routing

    // MARK: Navigation

    // MARK: Passing data

}
