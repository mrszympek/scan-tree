//
//  UIImageViewExtensions.swift
//  ScanTree
//
//  Created by Kamil on 20/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func sd_setImageWithFadeFrom(imageString: String?, placeholder: UIImage? = #imageLiteral(resourceName: "nav_products"), completion: (() -> Void)? = nil) {
        guard let imageString = imageString,
            let imageURL = URL(string: imageString) else {
                self.image = placeholder
                return
        }
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = CGPoint(x: self.frame.size.width / 2,
                                           y: self.frame.size.height / 2)
        activityIndicator.autoresizingMask = [.flexibleTopMargin,
                                              .flexibleLeftMargin ,
                                              .flexibleRightMargin ,
                                              .flexibleBottomMargin]
        activityIndicator.color = .black
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        sd_setImage(with: imageURL) { [weak self]
            (image, error, cacheType, url) -> Void in
            guard let self = self else {return}
            if let downLoadedImage = image {
                completion?()
                if cacheType == .none {
                    self.alpha = 0
                    UIView.transition(with: self,
                                      duration: 0.2,
                                      options: .transitionCrossDissolve,
                                      animations:
                        { [weak self] () -> Void in
                            self?.image = downLoadedImage
                            self?.alpha = 1
                        }, completion: nil)
                }
            }
            else {
                self.image = placeholder
            }
            activityIndicator.removeFromSuperview()
        }
    }
}


