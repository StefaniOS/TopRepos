//
//  GithubService.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 17.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

class SearchAPI: NetworkService {
    
    private func getURL(for request: SearchRequest) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = request.path
        components.queryItems = request.queryItems
        
        return components.url
    }
}

// MARK: - Search API methods
extension SearchAPI {
    func getRepositories(request: SearchRequest = SearchRequest(.mostPopular()), completion: @escaping (Result<Response, Error>) -> ()) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let url = self.getURL(for: request)!
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            
            guard let httpResponse = resp as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Server Error!")
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(Response.self, from: data!)
                completion(.success(response))
            } catch (let jsonError){
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
}
