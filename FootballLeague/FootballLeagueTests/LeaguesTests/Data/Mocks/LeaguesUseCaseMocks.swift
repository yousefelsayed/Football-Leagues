//
//  LeaguesUseCaseMock.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation
@testable import FootballLeague

class LeaguesUseCaseMocks: FootballLeague.LeaguesDataUseCase {
    var leaguesRepositoryMocks: LeaguesRepositoryMocks
    
    init(leaguesRepositoryMocks: LeaguesRepositoryMocks) {
        self.leaguesRepositoryMocks = leaguesRepositoryMocks
    }
    
    func fetchData() async throws -> FootballLeague.ResultCallback<FootballLeague.LeaguesResponse> {
        try await leaguesRepositoryMocks.getLeagues()
    }
    
    func getCachedLeagues() async throws -> Result<[FootballLeague.League], FootballLeague.CachDataError> {
        try await leaguesRepositoryMocks.getCachedLeagues()
        
    }
    
    func saveCurrentLeagues(_ leagues: FootballLeague.Leagues?) throws {
        try leaguesRepositoryMocks.cacheLeaguesData(leagues)
    }
    
}
