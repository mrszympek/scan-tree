//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol ProductDetailsPresentationLogic {
    func presentProductDetails(_ product: ProductDetails, isFavorite: Bool)
}

class ProductDetailsPresenter: ProductDetailsPresentationLogic {
    weak var viewController: ProductDetailsDisplayLogic?
    
    func presentProductDetails(_ product: ProductDetails, isFavorite: Bool) {
        viewController?.displayProductDetails(product, isFavorite: isFavorite)
    }
    
}
