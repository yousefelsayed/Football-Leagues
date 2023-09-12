//
//  LeagueTeamIModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation
import CoreData

struct LeagueTeams {
    var teams: [LeagueTeamsModel]
    
    func toEntity(in context: NSManagedObjectContext) -> LeagueTeamsEntity {
        var entity: LeagueTeamsEntity = .init(context: context)
        teams.forEach({ model in
            entity = LeagueTeamsEntity(context: context)
            entity.teamId = Int32(model.teamId)
            entity.teamName = model.teamName
            entity.teamShortName = model.teamShortName
            entity.teamCode = model.teamCode
            entity.teamLogo = model.teamLogo
        })
        return entity
    }
}

struct LeagueTeamsModel {
    var teamId: Int
    var teamName: String
    var teamShortName: String
    var teamCode: String
    var teamLogo: String
    
    init(_ entity: LeagueTeamsEntity) {
        self.teamId = Int(entity.teamId)
        self.teamName = entity.teamName ?? ""
        self.teamShortName = entity.teamShortName ?? ""
        self.teamCode = entity.teamCode ?? ""
        self.teamLogo = entity.teamLogo ?? ""
    }
}
