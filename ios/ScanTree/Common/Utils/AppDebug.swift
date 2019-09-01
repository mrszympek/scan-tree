//
//  AppDebug.swift
//  ScanTree
//
//  Created by Kamil Zajac on 01/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

class AppDebug {
    
    private init() {}
    
    static func initAppDebugging() {
        // SwiftyBeaver
        let console = ConsoleDestination()
        console.minLevel = .debug
        log.addDestination(console)
    }
    
}
