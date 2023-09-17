//
//  TeamsRepositoryTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest

@testable import FootballLeague

final class TeamsRepositoryTests: XCTestCase {
    var sut: TeamsRepositoryMocks!

    override func setUpWithError() throws {
        sut = TeamsRepositoryMocks()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getTeams_onSucess() async throws {
        sut.isSuccess = true
        
        let result = try await sut.getLeagueTeams("BRA")
        
        switch result {
            
        case let .success(teams):
            XCTAssertNotNil(teams)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getTeams_onInvalidResponse_OnFailure() async throws {
        sut.isSuccess = false

        let result = try await sut.getLeagueTeams("BRA")
        
        switch result {
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_getCachedTeams_onSucess() async throws {
        
        sut.isSuccess = true

        let result = try await sut.getCachedLeagueTeams("BRA")
        
        switch result {
            
        case let .success(teams):
            XCTAssertNotNil(teams)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getCachedTeams_onNoDataFound_OnFailure() async throws {
        sut.isSuccess = false

        let result = try await sut.getCachedLeagueTeams("BRA")

        switch result {
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No Cached data for league code for this team")
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_cacheTeams_OnSucess() async throws {
        sut.isSuccess = true
        
        let teams = LeagueTeamsIModel(TeamsModel(id: 123,shortName: "short name",crest: "url", tla: "tla",name: "name"),
                                      competition: CompetitionModel(id: 12, name: "name test", code: "code", emblem: "emblem", area: AreaModel(id: 123, name: "area", flag: "flag"), currentSeason: CurrentSeasonModel(id: 123, startDate: "start date", endDate: "end date", currentMatchday: 45), numberOfAvailableSeasons: 33))
        
        do {
            try sut.cacheLeagueTeamsData(LeagueTeams(teams: [teams]), leagueCode: "BRA")
            XCTAssertTrue(sut.cacheTeamsDataCalled)
        } catch {
            XCTFail("Caching leagues should not throw an error")
        }
    }
    
    func test_cacheTeams_OnFailure() async throws {
        sut.isSuccess = false
        
        let teams = LeagueTeamsIModel(TeamsModel(id: 123, shortName: "short name", crest: "url", tla: "tla", name: "name"), competition: CompetitionModel(id: 12, name: "name test", code: "code", emblem: "emblem", area: AreaModel(id: 123, name: "area", flag: "flag"), currentSeason: CurrentSeasonModel(id: 123, startDate: "start date", endDate: "end date", currentMatchday: 45), numberOfAvailableSeasons: 33))
    
        XCTAssertThrowsError(try sut.cacheLeagueTeamsData(LeagueTeams(teams: [teams]), leagueCode: "BRA"), "Cache teams should throw an error")
 
    }
}
