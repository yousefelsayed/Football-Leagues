//
//  URLSessionNetworkService.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//


import Foundation

class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func performRequest<T: Decodable>(endPoint: Endpoint, completion: @escaping ResultCallback<T>) {
        
        
        var urlComponents = URLComponents()
        urlComponents.host = endPoint.base
        urlComponents.path = endPoint.path
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.requestFailed(error)))
            }
        }
        
        task.resume()
    }
    

}
