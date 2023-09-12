//
//  League.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation
import CoreData

struct Leagues: Codable {
    var leagues: [League]
    
    func toEntity(in context: NSManagedObjectContext) -> LeaguesEntity {
        var entity: LeaguesEntity = .init(context: context)
        leagues.forEach({ model in
            entity = LeaguesEntity(context: context)
            entity.id = Int32(model.leagueId)
            entity.name = model.leagueName
            entity.areaName = model.leagueAreaName
            entity.code = model.leagueCode
            entity.logo = model.leagueLogo
            entity.numberOfGames = Int32(model.numberOfGames) ?? 0
            entity.numberOfTeams = Int32(model.numberOfTeams) ?? 0
        })
        return entity
    }
    
}

struct League : Codable,Hashable,Identifiable {
    var id = UUID() // Unique identifier

    var leagueId: Int
    var leagueName: String
    var leagueCode: String
    var leagueLogo: String
    var leagueAreaName: String
    var numberOfTeams: String
    var numberOfGames: String
    
    init(_ entity: LeaguesEntity) {
        self.leagueId = Int(entity.id)
        self.leagueName = entity.name ?? ""
        self.leagueLogo = entity.logo ?? ""
        self.leagueAreaName = entity.areaName ?? ""
        self.leagueCode = entity.code ?? ""
        self.numberOfGames = "\(Int(entity.numberOfGames))"
        self.numberOfTeams = "\(Int(entity.numberOfTeams))"
    }
    
    init(_ competition: CompetitionModel) {
        let teams = competition.currentSeason?.currentMatchday ?? 0
        let numberOfTeams = (teams / 2) + 1
        
        self.leagueId = Int.random(in: 0 ... 1000)
        self.leagueName = competition.name ?? ""
        self.leagueCode = competition.code ?? ""
        self.leagueLogo = competition.emblem ?? ""
        self.leagueAreaName = competition.area?.name ?? ""
        self.numberOfTeams = "\(numberOfTeams)"
        self.numberOfGames = "\(competition.currentSeason?.currentMatchday ?? 0)"
    }
}
