//
//  TeamMatchesDataRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation

protocol TeamMatchesDataRepository {
    func getTeamMatches(_ teamId: Int) async throws -> ResultCallback<TeamMatchesResponse>
    func getCachedTeamMatches(_ teamId: Int)  async throws -> Result<[TeamMatchesIModel], CachDataError>
    func cacheTeamMatches(_ matches: TeamMatches?, teamId: Int) throws
}
