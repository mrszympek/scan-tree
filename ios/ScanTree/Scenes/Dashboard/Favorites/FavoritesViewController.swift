//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit

protocol FavoritesDisplayLogic: class {
    func displayFetchProductsSuccess(_ viewModels: [Home.List.ViewModel])
    func displayProductDetails()
}

class FavoritesViewController: UIViewController, FavoritesDisplayLogic {

    // MARK: Outlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?
    
    private var viewModels: [Home.List.ViewModel] = []

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchProducts()
    }

    // MARK: View customization

    private func setupView() {
        navigationItem.title = "Favorites"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(
            UINib(nibName: "ProductTableViewCell", bundle: nil),
            forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier
        )
    }

    // MARK: Actions
    
    @IBAction func searchEditingChanged(_ sender: UITextField) {
        interactor?.search(withQuery: sender.text!)
    }

    // MARK: Display logic
    
    func displayFetchProductsSuccess(_ viewModels: [Home.List.ViewModel]) {
        dismissProgress()
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func displayProductDetails() {
        router?.navigateToProductDetails()
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        cell.setupCell(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.assignProduct(with: viewModels[indexPath.row].id)
    }
    
}
