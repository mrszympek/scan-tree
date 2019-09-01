//
//  UIViewControllerExtensions.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    
    // MARK: - Progress
    
    func showProgress() {
        SVProgressHUD.show()
    }
    
    func dismissProgress() {
        SVProgressHUD.dismiss()
    }
    
    func showInfo(_ info: String) {
        SVProgressHUD.showDismissableInfo(withStatus: info)
    }
    
    func showSuccess(_ success: String) {
        SVProgressHUD.showDismissableSuccess(withStatus: success)
    }
    
    func showError(_ error: String) {
        SVProgressHUD.showDismissableError(withStatus: error)
    }
    
    // MARK: - Navigation Items
    
    func setBackButtonItem(withUpdatingNavigationColorTo color: UIColor = .darkGray, andTitle title: String = "") {
        let backBarButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        backBarButton.setTitleTextAttributes(attributes, for: .highlighted)
        backBarButton.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.backBarButtonItem = backBarButton
        navigationController?.navigationBar.tintColor = color
    }
    
    // MARK: - Additonal extensions
    func addTapRecognizerToDismissKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
