//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesBusinessLogic {
}

protocol FavoritesDataStore {
}

class FavoritesInteractor: FavoritesBusinessLogic, FavoritesDataStore {
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker?

    // MARK: Bussines logic
}
