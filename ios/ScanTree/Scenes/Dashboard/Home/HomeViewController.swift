//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import QRCodeReader

protocol HomeDisplayLogic: class {
    func displayFetchProductsSuccess(_ viewModels: [Home.List.ViewModel])
    func displayFetchProductsError(error: String)
    func displayProductDetails()
    func displayUnableToFindProduct(error: String)
}

class HomeViewController: UIViewController, HomeDisplayLogic {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties

    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
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
        showProgress()
    }

    // MARK: View customization

    private func setupView() {
        navigationItem.title = "Products"
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
    
    @IBAction func scanPressed(_ sender: UIBarButtonItem) {
        router?.showQRCodeScanner()
    }
    
    // MARK: Display logic
    
    func displayFetchProductsError(error: String) {
        showError(error)
    }
    
    func displayFetchProductsSuccess(_ viewModels: [Home.List.ViewModel]) {
        dismissProgress()
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    func displayProductDetails() {
        router?.navigateToProductDetails()
    }
    
    func displayUnableToFindProduct(error: String) {
        showError(error)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension HomeViewController: QRCodeReaderViewControllerDelegate {
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.dismiss(animated: true, completion: nil)
        interactor?.assignProduct(with: result.value)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
