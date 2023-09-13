//
//  TeamMatchesIModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation
import CoreData

struct TeamMatches {
    var teams: [TeamMatchesIModel]
    
    func toEntity(in context: NSManagedObjectContext) -> TeamMatchesEntity {
        var entity: TeamMatchesEntity = .init(context: context)
        teams.forEach({ model in
            entity.matchId = Int32(model.matchId)
            entity.matchDate = model.matchDate
            entity.homeTeamName = model.homeTeamName
            entity.homeTeamLogo = model.awayTeamLogo
            entity.homeTeamScore = model.homeTeamScore
            entity.awayTeamLogo = model.awayTeamLogo
            entity.awayTeamScore = model.awayTeamScore
            entity.awayTeamName = model.homeTeamName
            entity.matchStatus = model.matchStatus
            
        })
        return entity
    }
}

struct TeamMatchesIModel: Codable,Hashable,Identifiable  {
    var id = UUID()
    
    var matchId: Int
    var matchDate: String
    var homeTeamName: String
    var homeTeamLogo: String
    var homeTeamScore: String
    var awayTeamName: String
    var awayTeamLogo: String
    var awayTeamScore: String
    var matchStatus: String
    
    
    init(_ entity: TeamMatchesEntity) {
        self.matchId = Int(entity.matchId)
        self.matchDate = entity.matchDate ?? ""
        self.homeTeamName = entity.homeTeamName ?? ""
        self.homeTeamLogo = entity.homeTeamLogo ?? ""
        self.homeTeamScore = entity.homeTeamScore ?? ""
        self.awayTeamLogo = entity.awayTeamLogo ?? ""
        self.awayTeamScore = entity.awayTeamScore ?? ""
        self.awayTeamName = entity.awayTeamName ?? ""
        self.matchStatus = entity.matchStatus ?? ""
    }

    
}
