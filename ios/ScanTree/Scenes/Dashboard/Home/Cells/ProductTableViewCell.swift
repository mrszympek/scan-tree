//
//  ProductTableViewCell.swift
//  ScanTree
//
//  Created by Kamil Zajac on 16/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProductTableViewCell"
    
    // MARK: - View customization
    
    func setupCell(with viewModel: Home.List.ViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
    
}
