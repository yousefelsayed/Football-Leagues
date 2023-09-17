//
//  APIEndPoint.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

class EndPoint {
    static let shared = EndPoint()
    
    private init() {}
    
    static let baseURL = "https://api.football-data.org/v4/"
    static let header: [String: String] = ["X-Auth-Token":"90deab14f2c8494396b2ba6ebf0dc2ac"]
    
    func createCustomURL(path: String, method: HTTPMethod) throws ->  URLRequest {
        let components = URLComponents(string: EndPoint.baseURL + path)
        
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = EndPoint.header
        
        return request
    }
}

