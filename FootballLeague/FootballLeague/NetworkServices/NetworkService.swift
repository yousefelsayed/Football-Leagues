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
    typealias ResultCallback<T> = (Result<T, NetworkError>) -> Void
    
    func performRequest<T: Decodable>(url: Endpoint, completion: @escaping ResultCallback<T>)
}
