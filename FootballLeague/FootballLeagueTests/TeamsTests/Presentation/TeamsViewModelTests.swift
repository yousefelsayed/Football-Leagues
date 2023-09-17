//
//  TeamsViewModelTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest
@testable import FootballLeague

final class TeamsViewModelTests: XCTestCase {
    
    var sut: LeagueTeamsViewModel!
    var useCase: TeamsUseCaseMocks!
    var repository: TeamsRepositoryMocks!
    
    
    override func setUpWithError() throws {
        repository = TeamsRepositoryMocks()
        useCase = TeamsUseCaseMocks(teamsRepositoryMocks: repository)
        sut = LeagueTeamsViewModel(leaguesUseCase: useCase,
                                   league: League(leagueId: 123, leagueName: "BRA", leagueLogo: "logo", leagueCode: "BRA",leagueAreaName: "area", numberOfTeams: "12", numberOfGames: "123"))
    }
    
    override func tearDownWithError() throws {
        repository = nil
        useCase = nil
        sut = nil
    }
    
    func test_getAllTeams_Should_Return_Success() {
        repository.isSuccess = true
        
        // Get data from the backend
        sut.getLeagueTeams()
        
        XCTAssertFalse(sut.teams.count > 0, "Couldn't load teams both on cache and server")
    }
    
    func test_getTeamsFromServer_Success() async throws {
        repository.isSuccess = true
        
        // Call the function to fetch teams from the server
        await sut.getLeagueTeamsFromServer("BRA")
        
        XCTAssertFalse((sut.sortedTeams?.isEmpty ?? true), "Teams should be loaded from the server")
    }
    
    func test_getTeamsFromServer_Failure() async throws {
        repository.isSuccess = false
        
        await sut.getLeagueTeamsFromServer("BRA")
        
        XCTAssertNotNil(sut.errorMessage, "Error message Appears")
    }
    
    func test_getCachedTeams_Success() async throws {
        repository.isSuccess = true
        let teams = LeagueTeams(teams:  [LeagueTeamsIModel(TeamsModel(id: 123, shortName: "short name", crest: "url", tla: "tla", name: "name"), competition: CompetitionModel(id: 12, name: "name test", code: "code", emblem: "emblem", area: AreaModel(id: 123, name: "area", flag: "flag"), currentSeason: CurrentSeasonModel(id: 123, startDate: "start date", endDate: "end date", currentMatchday: 45), numberOfAvailableSeasons: 33))])
        
        try repository.cacheLeagueTeamsData(teams, leagueCode: "BRA")
        
        // Call the function to fetch cached teams
        await sut.getCachedLeagueTeams(leagueCode: "BRA")
        
        XCTAssert((sut.sortedTeams?.count ?? 0) > 0, "Teams should be loaded from cache")
    }
    
    func test_getCachedTeams_Failure() async throws {
        repository.isSuccess = false
        
        // Call the function to fetch cached teams
        await sut.getCachedLeagueTeams(leagueCode: "BRA")
        
        XCTAssertTrue((sut.sortedTeams?.isEmpty ?? true), "Teams should be empty due to failure in fetching cached leagues")
    }
}
