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

// MARK: - Score
struct Score: Codable {
    let fullTime: Time?
}

// MARK: - MatchesModel
struct MatchesModel: Codable {
    let id: Int
    let score: Score
    let matchday: Int?
    let homeTeam: Team
    let lastUpdated: String?
    let competition: Competition?
    let area: Area?
    let stage: String?
    let odds: Odds?
    let season: Season?
    let awayTeam: Team?
    let utcDate: String?
    let status: String?
}

// MARK: - Area
struct Area: Codable {
    let code: String
    let id: Int
    let flag: String
    let name: String
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let crest: String
    let name, shortName, tla: String
}

// MARK: - Competition
struct Competition: Codable {
    let code: String
    let id: Int
    let emblem: String
    let name, type: String
}

// MARK: - Odds
struct Odds: Codable {
    let msg: String
}


// MARK: - Time
struct Time: Codable {
    let home, away: Int?
}

// MARK: - Season
struct Season: Codable {
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
}
