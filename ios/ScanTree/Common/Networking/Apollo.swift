//
//  Apollo.swift
//  ScanTree
//
//  Created by Kamil Zajac on 09/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation
import Apollo

class Apollo {
    static let shared = Apollo()
    
    private(set) lazy var client = ApolloClient(url: URL(string: "https://eu1.prisma.sh/bartek-piela-09119b/scantree/dev")!)
}
