//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol ProductDetailsDisplayLogic: class {
    func displayProductDetails(_ product: ProductDetails, isFavorite: Bool)
}

class ProductDetailsViewController: UIViewController, ProductDetailsDisplayLogic {

    // MARK: Outlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latinName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var varietyLabel: UILabel!
    
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
    
    @objc private func markAsFavorite() {
        interactor?.markAsFavorite()
    }

    // MARK: Display logic
    
    func displayProductDetails(_ product: ProductDetails, isFavorite: Bool) {
        title = product.name
        nameLabel.text = product.name
        priceLabel.text = "Price: \(product.price) zł"
        descriptionLabel.text = product.description
        latinName.text = product.latinName
        categoryLabel.text = "Price: \(product.category)"
        dateLabel.text = "Create date: \(product.createDate)"
        varietyLabel.text = "Variety: \(product.variety)"
        
        let buttonImage = UIImage(named: isFavorite ? "starFilled" : "star")
        let barButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: self, action: #selector(markAsFavorite))
        navigationItem.rightBarButtonItem = barButtonItem
    }

}
