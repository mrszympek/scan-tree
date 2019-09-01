//
//  UIViewExtensions.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // Mark: - Gradient
    
    func addGradient(withColors colors: [UIColor] = [.darkGray, .lightGray]) {
        let gradientView = GradientView(
            frame: bounds,
            colors: colors
        )
        insertSubview(gradientView, at: 0)
    }
    
}
