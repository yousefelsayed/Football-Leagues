//
//  MatchesRepositoryTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 17/09/2023.
//

import XCTest

@testable import FootballLeague

final class MatchesRepositoryTests: XCTestCase {
    var sut: MatchesRepositoryMocks!

    override func setUpWithError() throws {
        sut = MatchesRepositoryMocks()
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getMatches_onSucess() async throws {
        sut.isSuccess = true
        
        let result = try await sut.getTeamMatches(123)
        
        switch result {
        case let .success(matches):
            XCTAssertNotNil(matches)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getMatches_onInvalidResponse_OnFailure() async throws {
        sut.isSuccess = false

        let result = try await sut.getTeamMatches(123)
        
        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_getCachedMatches_onSucess() async throws {
        
        sut.isSuccess = true

        let result = try await sut.getCachedTeamMatches(123)
        
        switch result {
        case let .success(matches):
            XCTAssertNotNil(matches)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getCachedMatches_onNoDataFound_OnFailure() async throws {
        sut.isSuccess = false

        let result = try await sut.getCachedTeamMatches(123)

        switch result {
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No Cached data for team Id ")
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_cacheMatches_OnSucess() async throws {
        sut.isSuccess = true
        
       let matches = TeamMatches(matches: [TeamMatchesIModel(match: MatchesModel(id: 123,
                                                                                 score: Score(fullTime: Time(home: 2, away: 3)),
                                                                                 matchday: 12,
                                                                                 homeTeam: Team(id: 32, crest: "crest", name: "name",shortName: "short name", tla: "tla"),
                                                                                 lastUpdated: "last updated",
                                                                                 competition: Competition(code: "BRA", id: 123, emblem: "emblem", name: "name", type: "type"),
                                                                                 area: Area(code: "code", id: 12, flag: "flag",name: "name"),
                                                                                 stage: "stage", odds: Odds(msg: "message"),
                                                                                 season: Season(id: 34, startDate: "start", endDate: "end", currentMatchday: 2),
                                                                                 awayTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"),
                                                                                 utcDate: "date",
                                                                                 status: "status"), teamID: 123)])
        
        do {
           try sut.cacheTeamMatches(matches, teamId: 123)
            XCTAssertTrue(sut.cacheMatchesDataCalled)
        } catch {
            XCTFail("Caching matches should not throw an error")
        }
    }
    
    func test_cacheMatches_OnFailure() async throws {
        sut.isSuccess = false
        
        let matches = TeamMatches(
            matches: [TeamMatchesIModel(
                match: MatchesModel(id: 123,
                                    score: Score(fullTime: Time(home: 2, away: 3)),
                                    matchday: 12,
                                    homeTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"),
                                    lastUpdated: "last updated",
                                    competition: Competition(code: "BRA", id: 123, emblem: "emblem", name: "name", type: "type"), area: Area(code: "code", id: 12, flag: "flag", name: "name"),
                                    stage: "stage",
                                    odds: Odds(msg: "message"),
                                    season: Season(id: 34, startDate: "start", endDate: "end", currentMatchday: 2),
                                    awayTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"),
                                    utcDate: "date",
                                    status: "status"), teamID: 123)])
        
        
        
        XCTAssertThrowsError(try sut.cacheTeamMatches(matches, teamId: 123), "Cache matches should throw an error")
    }
}
