//
//  LeaguesMocksNetwork.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import Foundation
@testable import FootballLeague

class LeaguesRepositoryMocks: LeaguesDataRepository {
    var cacheLeaguesDataCalled = false
    var isSuccess: Bool = true
    
    func getLeagues() async throws -> FootballLeague.ResultCallback<FootballLeague.LeaguesResponse> {
        if isSuccess {
            if  let leaguesResponse = self.getMocksData() {
                return .success(leaguesResponse)
            }
        }
        else {
            return .failure(FootballLeague.NetworkError.invalidResponse)
        }
        return .failure(FootballLeague.NetworkError.invalidResponse)

    }
    
    func getFailedLeagues() async throws -> ResultCallback<LeaguesResponse> {
        return .failure(FootballLeague.NetworkError.invalidResponse)
    }
    
 
    

    //MARK: - Save data success
    func cacheLeaguesDataSuccess() async throws {
        // Create a mock leagues object
        let leagues = try await getCachedMockedLeagues()
      
        // Create a mock CoreDataManager
        let mockNetworkService = MockNetworkService<FootballLeague.Leagues>()
        // Initialize the repository with the mock CoreDataManager
        let mockCoreDataManager = MockCoreDataManager()

        let _ = LeaguesRepository(networkService: mockNetworkService, coreDataManager: mockCoreDataManager)
        
        switch leagues {
        case .success(let success):
            try self.cacheLeaguesData(success)
        case .failure(let failure):
            throw FootballLeague.CachDataError.onSaveError(failure)
        }
        
    }
    
    //MARK: - saving data failed
    func cacheLeaguesDataFailed() throws {
        throw CachDataError.onError("Saving leagues failed")
    }
    
    func getFailedCachedLeagues() async throws -> Result<FootballLeague.Leagues,CachDataError> {
        return .failure(FootballLeague.CachDataError.onError("No data found"))
    }
    
    //MARK: - Get dummy chached data on success
    func getCachedLeagues() async throws -> Result<[FootballLeague.League], FootballLeague.CachDataError> {
        if isSuccess {
            let league1 = League(
                leagueId: 0,
                leagueName: "DummyLeague",
                leagueLogo: "url", leagueCode: "DL",
                leagueAreaName: "area",
                numberOfTeams: "10",
                numberOfGames: "20")
            return .success([league1])
        } else {
            return .failure(CachDataError.onError("No Data Found"))
        }
    
    }
    
    func cacheLeaguesData(_ leagues: FootballLeague.Leagues?) throws {
        if (leagues?.leagues.isEmpty == false && isSuccess == true) {
            cacheLeaguesDataCalled = true
        } else {
            cacheLeaguesDataCalled = false
        }
    }
    
    
    //MARK: - Mocks leagues
    private func getMocksData() -> LeaguesResponse? {
        if let leaguesData = loadJSONData(fileName: "Leagues") {
            
            let leagues = parseJSONData(data: leaguesData)
            
            return leagues ?? nil
        }
        return nil
    }
    
    func getCachedMockedLeagues() async throws -> Result<FootballLeague.Leagues, FootballLeague.CachDataError> {
        let league1 =  League(
            leagueId: 0,
            leagueName: "DummyLeague",
            leagueLogo: "url", leagueCode: "DL",
            leagueAreaName: "area",
            numberOfTeams: "10",
            numberOfGames: "20")
        
        let leagues = Leagues(leagues: [league1])
        
        return .success(leagues)
        
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
