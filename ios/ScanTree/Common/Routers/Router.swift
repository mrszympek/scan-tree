//
//  Router.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import UIKit

protocol Router {
    var viewController: UIViewController? { get }
}

extension Router {
    
    var viewController: UIViewController? {
        return (self as AnyObject).value(forKey: "viewController") as? UIViewController
    }
    
}
