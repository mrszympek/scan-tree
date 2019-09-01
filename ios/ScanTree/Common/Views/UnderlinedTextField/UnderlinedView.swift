//
//  UnderlinedView.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

fileprivate let kFadeDuration = 0.2
fileprivate let kDrawDuration = 0.1

protocol UnderlinedView {
    /// TextView has text!, TextField has text?, so we can't simply use any of this to fulfill protocol. Because of it we require
    /// to return text as msg, which can be Optional
    var textInView: String? { get }
    
    var titleLabel: UILabel { get set }
    var errorLabel: UILabel { get set }
    
    var titleFontSize: CGFloat { get set }
    var errorFontSize: CGFloat { get set }
    
    var titleColor: UIColor { get set }
    var errorColor: UIColor { get set }
    var underlineColor: UIColor { get set }
    
    var placeholder: String? { get set }
    var margin: CGFloat { get set }
}

extension UnderlinedView where Self: UIView {
    
    // MARK: Setup view
    
    func setupTitleLabel() {
        titleLabel.text = placeholder
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        titleLabel.textColor = titleColor
        titleLabel.alpha = 0
    }
    
    func setupErrorLabel() {
        errorLabel.textAlignment = .right
        errorLabel.font = UIFont.systemFont(ofSize: errorFontSize)
        errorLabel.textColor = errorColor
        errorLabel.alpha = 0
        errorLabel.sizeToFit()
    }
    
    // MARK: Layout views
    
    func layoutTitleLabel(inView view: UIView) {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: margin).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: 0).isActive = true
        titleLabel.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 10).isActive = true
        if !(textInView ?? "").isEmpty {
            showTitle()
        }
    }
    
    func layoutErrorLabel(inView view: UIView) {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: margin).isActive = true
        errorLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -margin).isActive = true
        errorLabel.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: 18).isActive = true
    }
    
    // MARK: View animations
    
    func showTitle() {
        guard titleLabel.alpha == 0 else { return }
        UIView.animate(withDuration: kFadeDuration) {
            self.titleLabel.alpha = 1
        }
    }
    
    func hideTitle() {
        hideErrorLabel()
        guard titleLabel.alpha == 1 else { return }
        UIView.animate(withDuration: kFadeDuration) {
            self.titleLabel.alpha = 0
        }
    }
    
    func showErrorLabel(with error: String) {
        // When error - title label will have error color
        errorLabel.text = error
        UIView.animate(withDuration: kFadeDuration) {
            self.errorLabel.alpha = 1
        }
    }
    
    func hideErrorLabel() {
        // Restore regular title label color
        titleLabel.textColor = titleColor
        UIView.animate(withDuration: kFadeDuration, animations: {
            self.errorLabel.alpha = 0
        }, completion: { _ in
            self.errorLabel.text = ""
        })
    }
    
    // MARK: - State handling
    
    /// Marking textField as success
    /// - Changes underscore color
    /// - Hide error
    func success() {
        hideErrorLabel()
    }
    
    /// Marking textField as failure
    /// - Parameter error: message that should appear as an error
    /// - Changes underscore color
    /// - Show error
    func failure(error: String) {
        showErrorLabel(with: error)
    }
    
    /// Common method that is using for displaying the validation result on textField
    func showValidationResult(_ error: String?) {
        if let error = error {
            showErrorLabel(with: error)
        } else {
            success()
        }
    }
    
}


