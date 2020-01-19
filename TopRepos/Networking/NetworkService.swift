//
//  NetworkService.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

protocol NetworkService {
    func getRepository(by id: Int, completion: @escaping (Result<Repository, Error>) -> ())
    
    func getRepositories(request: SearchRequest, completion: @escaping (Result<Response, Error>) -> ())
}

extension NetworkService {
    func getRepository(by id: Int, completion: @escaping (Result<Repository, Error>) -> ()) {
    }
    
    func getRepositories(request: SearchRequest, completion: @escaping (Result<Response, Error>) -> ()) {
    }
}
