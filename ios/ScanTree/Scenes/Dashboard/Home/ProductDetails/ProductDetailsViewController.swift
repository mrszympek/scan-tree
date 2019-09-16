//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol ProductDetailsDisplayLogic: class {
    func displayProductDetails(_ product: ProductDetails)
}

class ProductDetailsViewController: UIViewController, ProductDetailsDisplayLogic {

    // MARK: Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Properties

    var interactor: ProductDetailsBusinessLogic?
    var router: (NSObjectProtocol & ProductDetailsRoutingLogic & ProductDetailsDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor?.setupViewWithData()
    }

    // MARK: View customization

    private func setupView() {

    }

    // MARK: Actions

    // MARK: Display logic
    
    func displayProductDetails(_ product: ProductDetails) {
        title = product.name
        nameLabel.text = product.name
        priceLabel.text = "\(product.price) zł"
        descriptionLabel.text = product.description
    }

}
