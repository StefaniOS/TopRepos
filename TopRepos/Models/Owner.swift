//
//  Owner.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

struct Owner: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    
    enum CodingKeys : String, CodingKey {
        case id, login, avatarUrl
    }
}
