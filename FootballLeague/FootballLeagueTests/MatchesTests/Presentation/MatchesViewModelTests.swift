//
//  MatchesViewModelTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 17/09/2023.
//

import XCTest
@testable import FootballLeague
final class MatchesViewModelTests: XCTestCase {
    
    var sut: TeamMatchesViewModel!
    var useCase: TeamMatchesDataUseCase!
    var repository: MatchesRepositoryMocks!
    
    
    override func setUpWithError() throws {
        repository = MatchesRepositoryMocks()
        useCase = MatchesUseCaseMocks(matchesRepositoryMocks: repository)
        sut = TeamMatchesViewModel(teamMatchUseCase: useCase, team: LeagueTeamsIModel(TeamsModel(id: 123, shortName: "short name", crest: "url", tla: "tla", name: "name"), competition: CompetitionModel(id: 12, name: "name test", code: "code", emblem: "emblem", area: AreaModel(id: 123, name: "area", flag: "flag"), currentSeason: CurrentSeasonModel(id: 123, startDate: "start date", endDate: "end date", currentMatchday: 45), numberOfAvailableSeasons: 33)))
    }
    override func tearDownWithError() throws {
        repository = nil
        useCase = nil
        sut = nil
        
    }
    
    
    func test_getAllMatches_Should_Return_Success() {
        repository.isSuccess = true
        
        // Get data from the backend
        sut.getTeamMatches()
        
        XCTAssertFalse(sut.matches.count > 0, "Couldn't load teams both on cache and server")
    }
    
    func test_getTeamMatchesFromServer_Success() async throws {
        repository.isSuccess = true
        
        // Call the function to fetch teams from the server
        await sut.getTeamMatchesFromServer(123)
        
        XCTAssertFalse((sut.sortedMatches.isEmpty), "matches should be loaded from the server")
    }
    
    func test_getTeamMatchesFromServer_Failure() async throws {
        repository.isSuccess = false
        
        await sut.getTeamMatchesFromServer(123)
        
        XCTAssertNotNil(sut.errorMessage, "Error message Appears")
    }
    
    func test_getCachedTeamMatches_Success() async throws {
        repository.isSuccess = true
        let matches = TeamMatches(matches: [TeamMatchesIModel(match: MatchesModel(id: 123, score: Score(fullTime: Time(home: 2, away: 3)), matchday: 12, homeTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"), lastUpdated: "last updated", competition: Competition(code: "BRA", id: 123, emblem: "emblem", name: "name", type: "type"), area: Area(code: "code", id: 12, flag: "flag", name: "name"), stage: "stage", odds: Odds(msg: "message"), season: Season(id: 34, startDate: "start", endDate: "end", currentMatchday: 2), awayTeam: Team(id: 32, crest: "crest", name: "name", shortName: "short name", tla: "tla"), utcDate: "date", status: "status"))])
        
        try repository.cacheTeamMatches(matches, teamId: 123)
        
        // Call the function to fetch cached matches
        await sut.getCachedTeamMatches(teamId: 123)
        
        XCTAssert((sut.sortedMatches.count) > 0, "Teams should be loaded from cache")
    }

        func test_getCachedLeagues_Failure() async throws {
            repository.isSuccess = false


            // Call the function to fetch cached matches
            await sut.getCachedTeamMatches(teamId: 123)

            XCTAssertTrue((sut.sortedMatches.isEmpty), "Error no team id to retreive cached matches")
        }
 

}
