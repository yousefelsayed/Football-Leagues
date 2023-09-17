//
//  LeagueTeams.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation

//MARK: - Leagues response
struct LeagueTeamsResponse: Codable {
    let teams: [TeamsModel]?
    let competition: CompetitionModel?
}

//MARK: - Team Model
struct TeamsModel: Codable {
    let id: Int?
    let shortName,crest,tla,name: String?
}
