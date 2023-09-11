//
//  APIEndPoint.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

class EndPoint {
    static let shared = EndPoint()
    
    private init() {
    }
    
    static let baseURL = "https://api.football-data.org/v4/"
    static let header: [String: String] = ["X-Auth-Token":"d9367a4c6c0e421eaaf871ec900c83d4"]
    
    func createCustomURL(path: String, method: HTTPMethod) throws ->  URLRequest {
        let components = URLComponents(string: EndPoint.baseURL + path)
        
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        print("Call End Point: ",url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = EndPoint.header
        
        return request
    }
}

