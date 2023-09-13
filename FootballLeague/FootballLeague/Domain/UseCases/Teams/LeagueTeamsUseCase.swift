//
//  LeagueTeamsUseCase.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation


protocol LeagueTeamsDataUseCase {
    func getLeagueTeams(_ leagueCode: String) async throws -> ResultCallback<LeagueTeamsResponse>
    func getCachedLeagueTeams(_ leagueCode: String) async throws -> Result<[LeagueTeamsIModel], CachDataError>
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueCode: String) throws
}

class LeagueTeamsUseCase: LeagueTeamsDataUseCase {
 
    private let repository: LeagueTeamsDataRepository
    
    init(repository: LeagueTeamsDataRepository) {
        self.repository = repository
    }
    
    
    
    func getLeagueTeams(_ leagueCode: String) async throws -> ResultCallback<LeagueTeamsResponse> {
        return try await repository.getLeagueTeams(leagueCode)
    }
    
    func getCachedLeagueTeams(_ leagueCode: String) async throws -> Result<[LeagueTeamsIModel], CachDataError> {
        return try await repository.getCachedLeagueTeams(leagueCode)
    }
    
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueCode: String) throws {
        try self.repository.cacheLeagueTeamsData(leagueTeams, leagueCode: leagueCode)
    }
    
}
