//
//  LeaguesDataUseCase.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 11/09/2023.
//

import Foundation


protocol LeaguesDataUseCase {
    func fetchData() async throws -> ResultCallback<LeaguesResponse>
    func getCachedLeagues() async throws -> Result<[League], CachDataError>
    func saveCurrentLeagues(_ leagues: Leagues?) throws
}


class LeaguesUseCase: LeaguesDataUseCase {

    
    private let repository: LeaguesDataRepository
    
    init(repository: LeaguesDataRepository) {
        self.repository = repository
    }
    
    func fetchData() async throws -> ResultCallback<LeaguesResponse> {
        return try await repository.getLeagues()
    }
    
    func getCachedLeagues() async throws -> Result<[League], CachDataError> {
        return try await repository.getCachedLeagues()
    }
    
    func saveCurrentLeagues(_ leagues: Leagues?) throws {
        try self.repository.cacheLeaguesData(leagues)
    }
    
}
