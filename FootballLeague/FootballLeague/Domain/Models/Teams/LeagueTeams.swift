//
//  LeagueTeams.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation

struct LeagueTeamsResponse: Codable {
    let teams: [TeamsModel]?
    let competition: CompetitionModel?
}

struct TeamsModel: Codable {
    let id: Int?
    let shortName,crest,tla,name: String?
}
