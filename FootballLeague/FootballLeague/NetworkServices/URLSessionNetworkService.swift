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
    
    func performRequest<T: Decodable>(endPoint: Endpoint) async throws -> Result<T, NetworkError> {
        
        var components = URLComponents(string: endPoint.base + endPoint.path)
        
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        print("Call End Point: ",url.absoluteString)
        var testrequest = URLRequest(url: url)
        testrequest.httpMethod = endPoint.method.rawValue
        testrequest.allHTTPHeaderFields = endPoint.header
        
//        var urlComponents = URLComponents()
//        urlComponents.host = endPoint.base
//        urlComponents.path = endPoint.path
//
//        guard let url = urlComponents.url else {
//            throw NetworkError.invalidURL
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = endPoint.method.rawValue
//        request.allHTTPHeaderFields = endPoint.header
        print(testrequest)
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: testrequest) { data, response, error in
                if let error = error {
                    continuation.resume(with: .failure(NetworkError.requestFailed(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    continuation.resume(with: .failure(NetworkError.invalidResponse))
                    return
                }
                
                guard let data1 = data else {
                    continuation.resume(with: .failure(NetworkError.invalidResponse))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data1)
                    continuation.resume(returning: .success(decodedData))
                } catch {
                    continuation.resume(with: .failure(NetworkError.requestFailed(error)))
                }
            }
            
            task.resume()
        }
        
    }
    

}
