//
//  LeagueTeamsUseCase.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation


protocol LeagueTeamsDataUseCase {
    func getLeagueTeams(_ leagueID: Int) async throws -> ResultCallback<LeagueTeamsResponse>
    func getCachedLeagueTeams(_ leagueID: Int) async throws -> Result<[LeagueTeamsIModel], CachDataError>
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueID: Int) throws
}

class LeagueTeamsUseCase: LeagueTeamsDataUseCase {
 
    private let repository: LeagueTeamsDataRepository
    
    init(repository: LeagueTeamsDataRepository) {
        self.repository = repository
    }
    
    
    
    func getLeagueTeams(_ leagueID: Int) async throws -> ResultCallback<LeagueTeamsResponse> {
        return try await repository.getLeagueTeams(leagueID)
    }
    
    func getCachedLeagueTeams(_ leagueID: Int) async throws -> Result<[LeagueTeamsIModel], CachDataError> {
        return try await repository.getCachedLeagueTeams(leagueID)
    }
    
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueID: Int) throws {
        try self.repository.cacheLeagueTeamsData(leagueTeams, leagueID: leagueID)
    }
    
}
