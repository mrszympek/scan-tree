//  Created by Kamil Zajac on 01/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

extension SignInViewController {

    // MARK: Setup

    func setup() {
        let viewController = self
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        let router = SignInRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router as? NSObject, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}
