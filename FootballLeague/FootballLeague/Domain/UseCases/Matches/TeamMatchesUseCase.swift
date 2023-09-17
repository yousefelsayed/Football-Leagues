//
//  TeamMatchesUseCase.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation

protocol TeamMatchesDataUseCase {
    func getTeamMatches(_ teamId: Int) async throws -> ResultCallback<TeamMatchesResponse>
    func getCachedTeamMatches(_ teamId: Int)  async throws -> Result<[TeamMatchesIModel], CachDataError>
    func cacheTeamMatches(_ matches: TeamMatches?, teamId: Int) throws
}

class TeamMatchesUseCase: TeamMatchesDataUseCase {
 
    private let repository: TeamMatchesDataRepository
    
    init(repository: TeamMatchesDataRepository) {
        self.repository = repository
    }
    
    func getTeamMatches(_ teamId: Int) async throws -> ResultCallback<TeamMatchesResponse> {
        return try await repository.getTeamMatches(teamId)
    }
    
    func getCachedTeamMatches(_ teamId: Int) async throws -> Result<[TeamMatchesIModel], CachDataError> {
        return try await repository.getCachedTeamMatches(teamId)
    }
    
    func cacheTeamMatches(_ matches: TeamMatches?, teamId: Int) throws {
        try self.repository.cacheTeamMatches(matches, teamId: teamId)
    }
}
