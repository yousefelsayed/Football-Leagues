//
//  LeagueTeamsDataRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation

protocol LeagueTeamsDataRepository {
    func getLeagueTeams(_ leagueID: Int) async throws -> ResultCallback<LeagueTeamsResponse>
    func getCachedLeagueTeams(_ leagueID: Int) async throws -> Result<[LeagueTeamsIModel], CachDataError>
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueID: Int) throws
}
