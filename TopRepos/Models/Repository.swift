//
//  Repository.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 17.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    let url: String
    let description: String
    let stars: Int
    let language: String?
    let forks: Int
    let watch: Int
    let owner: Owner
    
    enum CodingKeys : String, CodingKey {
        case id, name, fullName, description, language, owner
        case isPrivate = "private"
        case url = "htmlUrl"
        case stars = "stargazersCount"
        case forks = "forksCount"
        case watch = "watchersCount"
    }
}

struct Response: Decodable {
    let totalCount: Int
    let items: [Repository]
}
