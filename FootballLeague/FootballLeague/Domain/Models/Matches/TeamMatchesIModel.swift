//
//  TeamMatchesIModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation
import CoreData

//MARK: - Current match status
enum MatchStatus: String {
    case scheduled = "SCHEDULED"
    case played = "FINISHED"
    case timed = "TIMED"
}

//MARK: - Team Matches
struct TeamMatches {
    var matches: [TeamMatchesIModel]
    
    func toEntity(in context: NSManagedObjectContext) -> TeamMatchesEntity {
        var entity: TeamMatchesEntity = .init(context: context)
        matches.forEach({ model in
            entity = TeamMatchesEntity(context: context)
            entity.matchId = Int32(model.matchId)
            entity.matchDate = model.matchDate
            entity.homeTeamName = model.homeTeamName
            entity.homeTeamLogo = model.awayTeamLogo
            entity.homeTeamScore = model.homeTeamScore
            entity.awayTeamLogo = model.awayTeamLogo
            entity.awayTeamScore = model.awayTeamScore
            entity.awayTeamName = model.homeTeamName
            entity.matchStatus = model.matchStatus
            entity.teamId = Int32(model.teamID)
            
        })
        return entity
    }
}

//MARK: - Team Match IModel
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
    var teamID: Int
    
    init(_ entity: TeamMatchesEntity, teamID: Int) {
        self.matchId = Int(entity.matchId)
        self.matchDate = entity.matchDate ?? ""
        self.homeTeamName = entity.homeTeamName ?? ""
        self.homeTeamLogo = entity.homeTeamLogo ?? ""
        self.homeTeamScore = entity.homeTeamScore ?? ""
        self.awayTeamLogo = entity.awayTeamLogo ?? ""
        self.awayTeamScore = entity.awayTeamScore ?? ""
        self.awayTeamName = entity.awayTeamName ?? ""
        self.matchStatus = entity.matchStatus ?? ""
        self.teamID = teamID
    }

    init (match: MatchesModel, teamID: Int) {
        self.matchId = Int(match.id)
        self.matchDate = match.utcDate ?? ""
        self.homeTeamName = match.homeTeam.name
        self.homeTeamLogo = match.homeTeam.crest
        self.homeTeamScore =  "\(match.score.fullTime?.home ?? 0)"
        self.awayTeamLogo = match.awayTeam?.crest ?? ""
        self.awayTeamScore =  "\(match.score.fullTime?.away ?? 0)"
        self.awayTeamName = match.homeTeam.name
        self.matchStatus = match.status ?? ""
        self.teamID  = teamID
    }
    
}
