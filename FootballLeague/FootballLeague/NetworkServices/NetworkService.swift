//
//  NetworkService.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
}

protocol NetworkService {
    
    func performRequest<T: Decodable>(endPoint: Endpoint) async throws -> ResultCallback<T>
}
