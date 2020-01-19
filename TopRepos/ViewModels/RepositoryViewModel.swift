//
//  RepositoryViewModel.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

struct RepositoryViewModel {
    
    let id: Int
    let name: String
    let fullName: String
    let url: String
    let isPrivate: Bool
    let description: String
    let stars: Int
    let language: String?
    let forks: Int
    let watch: Int
    let owner: Owner
    
    init(repository: Repository) {
        self.id = repository.id
        self.name = repository.name
        self.fullName = repository.fullName
        self.url = repository.url
        self.isPrivate = repository.isPrivate // true
        self.description = repository.description
        self.stars = repository.stars
        self.language = repository.language
        self.forks = repository.forks
        self.watch = repository.watch
        self.owner = repository.owner
    }
    
    var imageName: String {
        return isPrivate ? "lock": "lock.open"
    }
}
