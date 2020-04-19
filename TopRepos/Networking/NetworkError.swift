//
//  NetworkError.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 19.04.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case network(_ description: String)
    case parsing(_ description: String)
}
