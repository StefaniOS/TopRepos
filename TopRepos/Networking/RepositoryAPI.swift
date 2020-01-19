//
//  RepositoryAPI.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

class RepositoryAPI: NetworkService {
    
    fileprivate func getURL(for id: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repositories/\(id)"
        
        return components.url
    }
}

// MARK: - Repository API methods
extension RepositoryAPI {
    func getRepository(by id: Int, completion: @escaping (Result<Repository, Error>) -> ()) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let url = self.getURL(for: id)!
        
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
                let response = try decoder.decode(Repository.self, from: data!)
                completion(.success(response))
            } catch (let jsonError){
                completion(.failure(jsonError))
            }
            
        }.resume()
    }
}
