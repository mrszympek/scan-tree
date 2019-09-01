//
//  SVProgressHUDExtensions.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import SVProgressHUD

extension SVProgressHUD {
    public static func showDismissableError(withStatus status: String) {
        addObservers()
        SVProgressHUD.showError(withStatus: status)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    public static func showDismissableInfo(withStatus status: String) {
        addObservers()
        SVProgressHUD.showInfo(withStatus: status)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    public static func showDismissableSuccess(withStatus status: String) {
        addObservers()
        SVProgressHUD.showSuccess(withStatus: status)
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    static func addObservers() {
        let nc = NotificationCenter.default
        nc.addObserver(
            self, selector: #selector(hudTapped(_:)),
            name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent,
            object: nil
        )
        nc.addObserver(
            self, selector: #selector(hudDisappeared(_:)),
            name: NSNotification.Name.SVProgressHUDWillDisappear,
            object: nil
        )
    }
    
    @objc
    private static func hudTapped(_ notification: Notification) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(.none)
    }
    
    @objc
    private static func hudDisappeared(_ notification: Notification) {
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
        nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDWillDisappear, object: nil)
        SVProgressHUD.setDefaultMaskType(.none)
    }
}


