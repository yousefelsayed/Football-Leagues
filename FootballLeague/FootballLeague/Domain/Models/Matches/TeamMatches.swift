//
//  TeamMatches.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation

struct TeamMatchesResponse: Codable {
    let matches: [MatchesModel]?
}


struct MatchesModel: Codable {
    let id: Int?
    let utcDate: String?
    let status: String?
    let homeTeam: TeamsModel?
    let awayTeam: TeamsModel?
    let score: Score?
}

// MARK: - Score
struct Score: Codable {
    let fullTime, halfTime: TimeModel?
}


// MARK: - Time
struct TimeModel: Codable {
    let home, away: String?
}
