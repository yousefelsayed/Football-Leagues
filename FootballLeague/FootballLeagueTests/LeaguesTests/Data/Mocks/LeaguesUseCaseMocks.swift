//
//  LeaguesUseCaseMock.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation
@testable import FootballLeague

class LeaguesUseCaseMocks: FootballLeague.LeaguesDataUseCase {
    var cacheLeaguesDataCalled = false
    var leaguesRepositoryMocks: LeaguesRepositoryMocks
    
    init(leaguesRepositoryMocks: LeaguesRepositoryMocks) {
        self.leaguesRepositoryMocks = leaguesRepositoryMocks
    }
    
    func fetchData() async throws -> FootballLeague.ResultCallback<FootballLeague.LeaguesResponse> {
        try await leaguesRepositoryMocks.getLeagues()
    }
    
    func getCachedLeagues() async throws -> Result<[FootballLeague.League], FootballLeague.CachDataError> {
        try await leaguesRepositoryMocks.getCachedLeagues()
        
    }
    
    func saveCurrentLeagues(_ leagues: FootballLeague.Leagues?) throws {
        try leaguesRepositoryMocks.cacheLeaguesData(leagues)
    }
    
    //MARK: - Mocks leagues
    private func getMocksData() -> LeaguesResponse? {
        if let leaguesData = loadJSONData(fileName: "Leagues") {
            
            let leagues = parseJSONData(data: leaguesData)
            
            return leagues ?? nil
        }
        return nil
    }
    
    private func parseJSONData(data: Data) ->  LeaguesResponse? {
        do {
            let items = try JSONDecoder().decode(LeaguesResponse.self, from: data)
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
