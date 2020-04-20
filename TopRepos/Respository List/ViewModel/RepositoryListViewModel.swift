//
//  RepositoryListViewModel.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 19.04.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

class RepositoryListViewModel {
    
    public static let topLimit = 20
    
    private let fetchingService: RepositoryFetcher!
    private var itemViewModels: [RepositoryRowViewModel] = []
    
    init(fetchingService: RepositoryFetcher) {
        self.fetchingService = fetchingService
    }
}

extension RepositoryListViewModel {
    func fetchData(completion: @escaping ([RepositoryRowViewModel]) -> ()) {
        fetchingService.getRepositories(request: SearchRequest(.mostPopular(RepositoryListViewModel.topLimit))) {  [weak self] result in
            
            switch result {
            case .success(let response):
                let viewModels = response.items.map(RepositoryRowViewModel.init)
                self?.itemViewModels = viewModels
                completion(viewModels)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
