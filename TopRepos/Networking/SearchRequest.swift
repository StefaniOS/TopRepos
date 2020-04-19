//
//  SearchRequest.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

enum SearchSort: String{
    case stars
    case forks
    case updated
}

enum SearchOrder: String {
    case asc
    case desc
}

enum SearchQuery {
    case mostPopular(_ top: Int = 20)
    // define more cases here e.g. trending
    
    var path: String {
        return "/search/repositories"
    }
    
    var items: [URLQueryItem] {
        switch self {
        case .mostPopular(let limit):
            return [
                URLQueryItem(name: "q", value: "stars:>50000"),
                URLQueryItem(name: "sort",
                             value: SearchSort.stars.rawValue),
                URLQueryItem(name: "order",
                             value: SearchOrder.desc.rawValue),
                URLQueryItem(name: "per_page", value: "\(limit)") // limit results
            ]
        }
    }
}

struct SearchRequest {
    let path: String
    let queryItems: [URLQueryItem]
    
    init(_ query: SearchQuery) {
        self.path = query.path
        self.queryItems = query.items
    }
}
