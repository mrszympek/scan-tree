//
//  UnderlinedTextField.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

protocol UnderlinedTextFieldDelegate: class {
    func rightButtonActionOnField(_ field: UnderlinedTextField)
}

/// Textfield which can handle correct or bad input and then display message do the user below.
class UnderlinedTextField: UITextField, UnderlinedView {
    
    // MARK: - IB Properties
    
    @IBInspectable var maxCharactersCount: Int = 0
    @IBInspectable var titleColor: UIColor = .darkGray
    @IBInspectable var errorColor: UIColor = .red
    @IBInspectable var underlineColor: UIColor = .darkGray
    @IBInspectable var margin: CGFloat = 15.0
    @IBInspectable var rightImage: UIImage? {
        didSet {
            setupRightImage()
        }
    }
    @IBInspectable var titleFontSize: CGFloat = 10 {
        didSet {
            adjustFontSizes()
        }
    }
    @IBInspectable var errorFontSize: CGFloat = 10 {
        didSet {
            adjustFontSizes()
        }
    }
    
    // MARK: - Views
    
    var titleLabel = UILabel()
    var errorLabel = UILabel()
    var underlineView = UIView()
    var rightImageButton: UIButton!
    private var roundedLayer: CAShapeLayer?
    
    // MARK: - Properties
    
    open override var placeholder: String? {
        didSet {
            titleLabel.text = placeholder
        }
    }
    open override var text: String? {
        didSet {
            didChangeText()
        }
    }
    var textInView: String? {
        return text
    }
    
    /// When view is initialized, on first `layoutSubviews` we will add constraints
    /// to additional views
    /// This will prevent running this code multiple times
    var areSubviewsConfigured = false
    
    var currentFontSize: CGFloat {
        return UIFont.systemFont(ofSize: 14, weight: .semibold).lineHeight - 4
    }
    
    private var textFieldInsets: UIEdgeInsets = UIEdgeInsets(
        top: UIFont.systemFont(ofSize: 14, weight: .semibold).lineHeight - 4,
        left: 15,
        bottom: UIFont.systemFont(ofSize: 14, weight: .semibold).lineHeight - 4,
        right: 15
    )
    
    
    private var insets: UIEdgeInsets {
        get {
            return textFieldInsets
        } set {
            textFieldInsets = newValue
        }
    }
    
    weak var buttonDelegate: UnderlinedTextFieldDelegate?
    
    // MARK: - Object lifecycle
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View lifecycle
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if !areSubviewsConfigured {
            // This should be called only once
            
            layoutTitleLabel(inView: self)
            layoutErrorLabel(inView: self)
            areSubviewsConfigured = true
        }
    }
    
    // MARK: - Setup view
    
    /// Setup neccesarry views on init and prepareForInterfaceBuilder
    /// - Set borderStyle to .none
    /// - Create underscore
    /// - Create title label
    /// - Create optional delete mark
    /// - Create error label
    /// - Add .textDiDChangeNotification to self
    private func setup() {
        borderStyle = .none
        backgroundColor = .clear
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        setupTitleLabel()
        setupErrorLabel()
        setupRightImage()
        addObservers()
    }
    
    private func addObservers() {
        // We want tu be notified whenever user changes text it text field
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeText),
                                               name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func setupRightImage() {
        rightImageButton?.removeFromSuperview()
        rightImageButton = UIButton(type: .custom)
        addSubview(rightImageButton!)
        rightImageButton.imageView?.contentMode = .scaleAspectFit
        rightImageButton.setImage(rightImage, for: .normal)
        rightImageButton.addTarget(self, action: #selector(rigtButtonImageAction), for: .touchUpInside)
        rightImageButton.translatesAutoresizingMaskIntoConstraints = false
        rightImageButton.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -margin).isActive = true
        rightImageButton.centerYAnchor.constraint(
            equalTo: centerYAnchor,
            constant: (textFieldInsets.top - textFieldInsets.bottom) / 2).isActive = true
        if let rightImage = rightImage {
            insets.right = rightImage.size.width + 2 * margin
        }
        rightImageButton.isHidden = true
        layoutIfNeeded()
    }
    
    /// Called whenver user changes font size of one of the labels
    private func adjustFontSizes() {
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        errorLabel.font = UIFont.systemFont(ofSize: errorFontSize)
    }
    
    // MARK: - Actions
    
    @objc private func didChangeText() {
        guard let text = text else {
            // Set nil text, hide title
            hideTitle()
            return
        }
        // If text not empty - show title with animation
        if text.isEmpty {
            insets.top = currentFontSize
            insets.bottom = currentFontSize
            rightImageButton.isHidden = true
            hideTitle()
        } else {
            insets.top = currentFontSize + 10
            insets.bottom = currentFontSize - 10
            rightImageButton.isHidden = false
            showTitle()
        }
        guard maxCharactersCount != 0, text.count > maxCharactersCount else {
            return
        }
        let endIndex = text.index(before: text.endIndex)
        self.text = String(text[..<endIndex])
    }
    
    @objc private func rigtButtonImageAction() {
        buttonDelegate?.rightButtonActionOnField(self)
    }
    
    // MARK: - Draw
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}

