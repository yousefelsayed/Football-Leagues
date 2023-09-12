//
//  LeagueTeamIModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation

struct LeagueTeams {
    var teams: [LeagueTeamsModel]
}

struct LeagueTeamsModel {
    var teamId: Int
    var teamName: String
    var teamShortName: String
    var teamCode: String
    var teamLogo: String
    
    init(teamId: Int, teamName: String, teamShortName: String, teamCode: String, teamLogo: String) {
        self.teamId = teamId
        self.teamName = teamName
        self.teamShortName = teamShortName
        self.teamCode = teamCode
        self.teamLogo = teamLogo
    }
}
