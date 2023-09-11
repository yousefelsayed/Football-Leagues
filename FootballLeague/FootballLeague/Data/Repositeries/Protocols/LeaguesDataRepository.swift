//
//  LeaguesProtocol.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation


protocol LeaguesDataRepository {
    func getLeagues() async throws -> ResultCallback<LeaguesResponse>
    func getCachedLeagues() async throws -> Result<[League], CachDataError>
    func cacheLeaguesData(_ leagues: Leagues?) throws 
}
