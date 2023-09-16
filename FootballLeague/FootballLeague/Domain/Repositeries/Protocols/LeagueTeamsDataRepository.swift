//
//  LeagueTeamsDataRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation

protocol LeagueTeamsDataRepository {
    func getLeagueTeams(_ leagueCode: String) async throws -> ResultCallback<LeagueTeamsResponse>
    func getCachedLeagueTeams(_ leagueCode: String) async throws -> Result<[LeagueTeamsIModel], CachDataError>
    func cacheLeagueTeamsData(_ leagueTeams: LeagueTeams?, leagueCode: String) throws
}
