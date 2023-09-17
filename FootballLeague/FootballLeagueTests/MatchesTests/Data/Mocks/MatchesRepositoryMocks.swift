//
//  MatchesRepositoryMocks.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation
@testable import FootballLeague

class MatchesRepositoryMocks: TeamMatchesDataRepository {
 
    var cacheMatchesDataCalled = false
    var isSuccess: Bool = true
    
    
    func getTeamMatches(_ teamId: Int) async throws -> FootballLeague.ResultCallback<FootballLeague.TeamMatchesResponse> {
        if isSuccess {
            if  let matchesResponse = self.getMocksData() {
                return .success(matchesResponse)
            }
        } else {
            return .failure(FootballLeague.NetworkError.invalidResponse)
        }
        return .failure(FootballLeague.NetworkError.invalidResponse)
    }
    
    func getCachedTeamMatches(_ teamId: Int) async throws -> Result<[FootballLeague.TeamMatchesIModel], FootballLeague.CachDataError> {
        if isSuccess {
            let matches = [TeamMatchesIModel(match: MatchesModel(id: 123,
                                                                 score: Score(fullTime: Time(home: 2, away: 3)),
                                                                 matchday: 12,
                                                                 homeTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"),
                                                                 lastUpdated: "last updated",
                                                                 competition: Competition(code: "BRA", id: 123, emblem: "emblem", name: "name", type: "type"),
                                                                 area: Area(code: "code", id: 12, flag: "flag", name: "name"),
                                                                 stage: "stage", odds: Odds(msg: "message"),
                                                                 season: Season(id: 34, startDate: "start", endDate: "end", currentMatchday: 2),
                                                                 awayTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"),
                                                                 utcDate: "date",
                                                                 status: "status"), teamID: 123)]
            return .success(matches)
        } else {
            return .failure(FootballLeague.CachDataError.onError("No Cached data for team Id "))
        }
    }
    
    func cacheTeamMatches(_ matches: FootballLeague.TeamMatches?, teamId: Int) throws {
        if (matches?.matches.isEmpty == false && isSuccess == true) {
            cacheMatchesDataCalled = true
        } else {
            cacheMatchesDataCalled = false
            throw CachDataError.onError("Saving matches failed")
        }
    }
   
    
    //MARK: - Mocks leagues
    private func getMocksData() -> TeamMatchesResponse? {
        if let teamsData = loadJSONData(fileName: "Matches") {
            
            let teams = parseJSONData(data: teamsData)
            
            return teams ?? nil
        }
        
        return nil
    }
    
    private func parseJSONData(data: Data) ->  TeamMatchesResponse? {
        do {
            let items = try JSONDecoder().decode(TeamMatchesResponse.self, from: data)
            return items
        } catch {
            print("Failed to decode JSON data: \(error.localizedDescription)")
            return nil
        }
    }
    
    private  func loadJSONData(fileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "geojson") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Failed to read data from file: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
}
