//
//  RepositoryViewModelTest.swift
//  TopReposTests
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import XCTest
@testable import TopRepos

class RepositoryViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRepositoryViewModel() {
        let repository = Repository(id: 32452348, name: "testrepo", fullName: "test/testrepos", isPrivate: false, url: "https://api.github.com/repos/test/testrepo", description: "A repository for testing", stars: 293488, language: nil, forks: 293488, watch: 92734, owner: Owner(id: 9238, login: "hacker", avatarUrl: "https://avatars1.githubusercontent.com/u/22552083?v=4"))
        
        let viewModel = RepositoryViewModel(repository: repository)
        
        XCTAssertEqual(repository.id, viewModel.id)
        XCTAssertEqual(repository.name, viewModel.name)
        XCTAssertEqual(repository.fullName, viewModel.fullName)
        XCTAssertEqual(repository.url, viewModel.url)
        XCTAssertEqual(repository.description, viewModel.description)
        XCTAssertEqual(repository.stars, viewModel.stars)
        XCTAssertEqual(repository.forks, viewModel.forks)
        XCTAssertEqual(repository.watch, viewModel.watch)
        XCTAssertEqual(repository.language, viewModel.language)
        
        XCTAssertEqual(repository.owner.id, viewModel.owner.id)
        XCTAssertEqual(repository.owner.login, viewModel.owner.login)
        XCTAssertEqual(repository.owner.avatarUrl, viewModel.owner.avatarUrl)
        
        XCTAssertNotEqual(viewModel.name, "Test Repo")
        XCTAssertNotEqual(viewModel.stars, repository.stars+1)
        XCTAssertNotNil(viewModel.owner.avatarUrl)
    }
}
