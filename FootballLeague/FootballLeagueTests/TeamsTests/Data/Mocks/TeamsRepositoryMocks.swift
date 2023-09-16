//
//  TeamsRepositoryMocks.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation

@testable import FootballLeague
class TeamsRepositoryMocks: LeagueTeamsDataRepository {
    var cacheTeamsDataCalled = false
    var isSuccess: Bool = true
    
    func getLeagueTeams(_ leagueCode: String) async throws -> FootballLeague.ResultCallback<FootballLeague.LeagueTeamsResponse> {
        if isSuccess {
            if  let teamsResponse = self.getMocksData() {
                return .success(teamsResponse)
            }
        }
        else {
            return .failure(FootballLeague.NetworkError.invalidResponse)
        }
        return .failure(FootballLeague.NetworkError.invalidResponse)
        
    }
    
    func getCachedLeagueTeams(_ leagueCode: String) async throws -> Result<[FootballLeague.LeagueTeamsIModel], FootballLeague.CachDataError> {
        if isSuccess {
            let teams = LeagueTeamsIModel(TeamsModel(id: 123, shortName: "short name", crest: "url", tla: "tla", name: "name"), competition: CompetitionModel(id: 12, name: "name test", code: "code", emblem: "emblem", area: AreaModel(id: 123, name: "area", flag: "flag"), currentSeason: CurrentSeasonModel(id: 123, startDate: "start date", endDate: "end date", currentMatchday: 45), numberOfAvailableSeasons: 33))
            return .success([teams])
            
        } else {
            return .failure(CachDataError.onError("No Cached data for league code for this team"))
        }
    }
    
    func cacheLeagueTeamsData(_ leagueTeams: FootballLeague.LeagueTeams?, leagueCode: String) throws {
        if (leagueTeams?.teams.isEmpty == false && isSuccess == true) {
            cacheTeamsDataCalled = true
        } else {
            cacheTeamsDataCalled = false
        }
    }
    
    
    //MARK: - Mocks leagues
    private func getMocksData() -> LeagueTeamsResponse? {
        if let teamsData = loadJSONData(fileName: "Teams") {
            
            let teams = parseJSONData(data: teamsData)
            
            return teams ?? nil
        }
        return nil
    }
    
    private func parseJSONData(data: Data) ->  LeagueTeamsResponse? {
        do {
            let items = try JSONDecoder().decode(LeagueTeamsResponse.self, from: data)
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
