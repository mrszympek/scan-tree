//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol SignInRoutingLogic: MainAppRouter {
}

protocol SignInDataPassing {
    var dataStore: SignInDataStore? { get }
}

class SignInRouter: NSObject, SignInRoutingLogic, SignInDataPassing {
    @objc weak var viewController: SignInViewController?
    var dataStore: SignInDataStore?

    // MARK: Routing

    // MARK: Navigation

    // MARK: Passing data

}
