//
//  League.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

struct Leagues {
    var leagues: [League]
}

struct League : Identifiable,Hashable {
    let id = UUID()

    var leagueId: Int
    var leagueName: String
    var leagueCode: String
    var leagueLogo: String
    var leagueAreaName: String
    var numberOfTeams: String
    var numberOfGames: String
}
