//
//  LeaguesResponse.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

//MARK: - Leagues Respone
struct LeaguesResponse: Codable {
    let count: Int?
    let competitions: [CompetitionModel]?
}

//MARK: - Competition Model
struct CompetitionModel: Codable {
    let id: Int?
    let name: String?
    let code: String?
    let emblem: String?
    let area: AreaModel?
    let currentSeason: CurrentSeasonModel?
    let numberOfAvailableSeasons: Int?
}

//MARK: - Area Model
struct AreaModel: Codable {
    let id: Int?
    let name: String?
    let flag: String?
}

//MARK: - Current Season Model
struct CurrentSeasonModel: Codable {
    let id: Int?
    let startDate: String?
    let endDate: String?
    let currentMatchday: Int?
}
