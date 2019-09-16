//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesRoutingLogic: Router {
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: NSObject, FavoritesRoutingLogic, FavoritesDataPassing {
    @objc weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?

    // MARK: Routing

    // MARK: Navigation

    // MARK: Passing data

}
