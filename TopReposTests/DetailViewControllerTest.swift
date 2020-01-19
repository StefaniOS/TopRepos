//
//  DetailViewControllerTest.swift
//  TopReposTests
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import XCTest
@testable import TopRepos

class MockNetworkService: NetworkService {
    
    func getRepository(by id: Int, completion: @escaping (Result<Repository, Error>) -> ()) {
        let repository = Repository(id: 32452348, name: "testrepo", fullName: "test/testrepos", isPrivate: false, url: "https://api.github.com/repos/test/testrepo", description: "A repository for testing", stars: 293488, language: nil, forks: 293488, watch: 92734, owner: Owner(id: 9238, login: "hacker", avatarUrl: "https://avatars1.githubusercontent.com/u/22552083?v=4"))
        
        completion(.success(repository))
    }
}

class DetailViewControllerTest: XCTestCase {

    private var detailVC: RepositoryDetailViewController!
    private var viewModel: RepositoryViewModel!
    private var networkService: NetworkService!
    private var repository: Repository!
    
    override func setUp() {
        super.setUp()
        
        // The selected repository from repository list
        repository = Repository(id: 32452348, name: "", fullName: "", isPrivate: false, url: "", description: "", stars: 293488, language: nil, forks: 293488, watch: 0, owner: Owner(id: 0, login: "", avatarUrl: ""))
        
        viewModel = RepositoryViewModel(repository: repository)
        
        networkService = MockNetworkService()
        
        detailVC = RepositoryDetailViewController(viewModel: viewModel, networkService: networkService)
//        detailVC.viewDidLoad()
    }

    override func tearDown() {
        detailVC = nil
        viewModel = nil
        networkService = nil
        super.tearDown()
    }
    
    func testViewModel() {
        networkService.getRepository(by: viewModel.id) { result in
            switch result {
            case .success(let repository):
                self.viewModel = RepositoryViewModel(repository: repository)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        XCTAssertNotEqual(viewModel.fullName, "")
        XCTAssertEqual(viewModel.fullName, "test/testrepos")
    }
    
    func testUpdateContentView() {

        //Test 1
        detailVC.updateContentView(with: viewModel)
        XCTAssertEqual(detailVC.titleLabel.text, viewModel.fullName)
        XCTAssertEqual(detailVC.titleLabel.text, "")

        // Test 2
        networkService.getRepository(by: viewModel.id) { result in
            switch result {
            case .success(let repository):
                self.viewModel = RepositoryViewModel(repository: repository)
                self.detailVC.updateContentView(with: self.viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        XCTAssertEqual(detailVC.titleLabel.text, viewModel.fullName)
        XCTAssertEqual(detailVC.titleLabel.text,"test/testrepos")
        XCTAssertEqual(detailVC.titleLabel.text, viewModel.fullName)
    }
}
