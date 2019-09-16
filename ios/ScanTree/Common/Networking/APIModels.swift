//
//  APIModels.swift
//  ScanTree
//
//  Created by Kamil Zajac on 16/09/2019.
//  Copyright © 2019 KamilZając. All rights reserved.
//

import Foundation

typealias FetchResultCompletion<T> = (FetchResult<T>) -> ()

enum FetchResult<T> {
    case failure(Error)
    case success(T)
}
