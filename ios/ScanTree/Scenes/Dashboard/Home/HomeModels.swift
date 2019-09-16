//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import Apollo

enum Home {
    enum List {
        struct ViewModel {
            let id: GraphQLID
            let name: String
            let description: String
            let price: String?
        }
    }
}
