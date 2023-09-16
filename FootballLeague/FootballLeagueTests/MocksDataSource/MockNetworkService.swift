//
//  MockNetworkService.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//


import Foundation
@testable import FootballLeague
class MockNetworkService<T: Decodable>: NetworkService {
    var performRequestCalled = false // A flag to track if performRequest was called
    var mockResult: Result<T, NetworkError>?

    func performRequest<T: Decodable>(endPoint: String, method: HTTPMethod) async throws -> Result<T, NetworkError> {
        // Set the flag to indicate performRequest was called
        performRequestCalled = true

        if let mockResult = mockResult as? Result<T, NetworkError> {
            return mockResult
        }

      
        return .failure(.invalidResponse)
    }
}
