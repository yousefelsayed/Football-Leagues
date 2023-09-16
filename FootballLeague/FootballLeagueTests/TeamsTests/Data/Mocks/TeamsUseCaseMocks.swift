//
//  TeamsUseCaseMocks.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation

@testable import FootballLeague

class TeamsUseCaseMocks: FootballLeague.LeagueTeamsDataUseCase {
    
    var teamsRepositoryMocks: TeamsRepositoryMocks
    
    init(teamsRepositoryMocks: TeamsRepositoryMocks) {
        self.teamsRepositoryMocks = teamsRepositoryMocks
    }
    
    func getLeagueTeams(_ leagueCode: String) async throws -> FootballLeague.ResultCallback<FootballLeague.LeagueTeamsResponse> {
        try await teamsRepositoryMocks.getLeagueTeams(leagueCode)
    }
    
    func getCachedLeagueTeams(_ leagueCode: String) async throws -> Result<[FootballLeague.LeagueTeamsIModel], FootballLeague.CachDataError> {
        try await teamsRepositoryMocks.getCachedLeagueTeams(leagueCode)
    }
    
    func cacheLeagueTeamsData(_ leagueTeams: FootballLeague.LeagueTeams?, leagueCode: String) throws {
        try  teamsRepositoryMocks.cacheLeagueTeamsData(leagueTeams, leagueCode: leagueCode)
    }
    
    
}
