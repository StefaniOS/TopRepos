//
//  RepositoryDetailViewModel.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 19.04.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

class RepositoryDetailViewModel {
    
    private let fetchingService: RepositoryFetcher!
    private(set) var rowItemViewModel: RepositoryRowViewModel!
    private var repositoryDetailViewModel: RepositoryRowViewModel?
    
    init(fetchingService: RepositoryFetcher, rowItemViewModel: RepositoryRowViewModel) {
        self.fetchingService = fetchingService
        self.rowItemViewModel = rowItemViewModel
    }
}

extension RepositoryDetailViewModel {
    func fetchData(completion: @escaping (RepositoryRowViewModel) -> ()) {
        
        fetchingService.getRepository(by: rowItemViewModel.id) { [unowned self] result in
            
            switch result {
            case .success(let repository):
                let rowViewModel = RepositoryRowViewModel(repository: repository)
                self.repositoryDetailViewModel = rowViewModel
                completion(rowViewModel)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


