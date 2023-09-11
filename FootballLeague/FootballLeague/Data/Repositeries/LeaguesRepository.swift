//
//  LeaguesRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation


class LeaguesRepository: LeaguesDataRepository {
    

    private let networkService: NetworkService
    //TODO: - cached layer
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    //MARK: - get leagues response and return complition
    func getLeagues() async throws -> ResultCallback<LeaguesResponse> {
        let endPoint = "competitions"
        
        return try await networkService.performRequest(endPoint: endPoint, method: .get)
    }
    
    
}
