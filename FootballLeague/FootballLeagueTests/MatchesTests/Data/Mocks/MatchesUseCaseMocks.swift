//
//  MatchesUseCaseMocks.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 17/09/2023.
//

import Foundation
@testable import FootballLeague

class MatchesUseCaseMocks: FootballLeague.TeamMatchesDataRepository {
    
    var matchesRepositoryMocks: MatchesRepositoryMocks
    
    init(matchesRepositoryMocks: MatchesRepositoryMocks) {
        self.matchesRepositoryMocks = matchesRepositoryMocks
    }
    
    func getTeamMatches(_ teamId: Int) async throws -> FootballLeague.ResultCallback<FootballLeague.TeamMatchesResponse> {
        try await matchesRepositoryMocks.getTeamMatches(teamId)
    }
    
    func getCachedTeamMatches(_ teamId: Int) async throws -> Result<[FootballLeague.TeamMatchesIModel], FootballLeague.CachDataError> {
        try await matchesRepositoryMocks.getCachedTeamMatches(teamId)
    }
    
    func cacheTeamMatches(_ matches: FootballLeague.TeamMatches?, teamId: Int) throws {
        try matchesRepositoryMocks.cacheTeamMatches(matches, teamId: teamId)
    }
   
    
}
