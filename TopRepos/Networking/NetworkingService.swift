//
//  NetworkingService.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation

protocol RepositoryFetcher {
    func getRepository(by id: Int, completion: @escaping (Result<Repository, NetworkError>) -> ())
    
    func getRepositories(request: SearchRequest, completion: @escaping (Result<Response, NetworkError>) -> ())
}

class NetworkingService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkingService {
    
    struct baseComponents {
        static let scheme = "https"
        static let host = "api.github.com"
    }
    
    func components(with id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = baseComponents.scheme
        components.host = baseComponents.host
        components.path = "/repositories/\(id)"
        return components
    }
    
    func components(for request: SearchRequest) -> URLComponents {
        var components = URLComponents()
        components.scheme = baseComponents.scheme
        components.host = baseComponents.host
        components.path = request.path
        components.queryItems = request.queryItems
        return components
    }
}

extension NetworkingService: RepositoryFetcher {
    func getRepository(by id: Int, completion: @escaping (Result<Repository, NetworkError>) -> ()) {
        fetch(with: components(with: id), completion: completion)
    }
    
    func getRepositories(request: SearchRequest, completion: @escaping (Result<Response, NetworkError>) -> ()) {
        fetch(with: components(for: request), completion: completion)
    }
    
    func fetch<T>(with components: URLComponents, completion: @escaping (Result<T, NetworkError>) -> ()) where T: Decodable {
        
        guard let url = components.url else {
            return
        }
        
        session.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(.failure(.network(err.localizedDescription)))
            }
            
            guard let httpResponse = resp as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(resp.debugDescription)")
                    return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(T.self, from: data!)
                completion(.success(response))
            } catch (let jsonError){
                completion(.failure(.parsing(jsonError.localizedDescription)))
            }
            
        }.resume()
    }
}
