//
//  LeaguesViewModelTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest
@testable import FootballLeague

final class LeaguesViewModelTests: XCTestCase {
    
    var sut: LeaguesViewModel!
    var useCase: LeaguesUseCaseMocks!
    var repository: LeaguesRepositoryMocks!
    
    
    override func setUpWithError() throws {
        repository = LeaguesRepositoryMocks()
        useCase = LeaguesUseCaseMocks(leaguesRepositoryMocks: repository)
        sut = LeaguesViewModel(leaguesUseCase: useCase)
    }
    
    override func tearDownWithError() throws {
        repository = nil
        useCase = nil
        sut = nil
        
    }
    
    
    func test_getAllLeagues_Should_Return_Success() {
        repository.isSuccess = true
        
        // Get data from the backend
        sut.getLeagues()
        
        XCTAssertFalse(sut.leagues.count > 0, "Couldn't load leagues both on cache and server")
    }
    
    func test_getLeaguesFromServer_Success() async throws {
        repository.isSuccess = true
        
        // Call the function to fetch leagues from the server
        await sut.getLeaguesFromServer()
        
        XCTAssertFalse((sut.sortedLeagues?.isEmpty ?? true), "Leagues should be loaded from the server")
    }
    
    func test_getLeaguesFromServer_Failure() async throws {
        repository.isSuccess = false
        
        await sut.getLeaguesFromServer()
        
        XCTAssertNotNil(sut.errorMessage, "Error message Appears")
    }
    
    func test_getCachedLeagues_Success() async throws {
        repository.isSuccess = true
        let leagues = Leagues(leagues: [League(leagueId: 1, leagueName: "Test League", leagueLogo: "testlogo", leagueCode: "TL", leagueAreaName: "Test Area", numberOfTeams: "20", numberOfGames: "50")])
        
        try repository.cacheLeaguesData(leagues)
        
        // Call the function to fetch cached leagues
        await sut.getCachedLeagues()
        
        XCTAssert((sut.sortedLeagues?.count ?? 0) > 0, "Leagues should be loaded from cache")
    }

        func test_getCachedLeagues_Failure() async throws {
            repository.isSuccess = false

            // Simulate failure in fetching cached leagues

            // Call the function to fetch cached leagues
            await sut.getCachedLeagues()

            XCTAssertTrue(sut.leagues.isEmpty, "Leagues should be empty due to failure in fetching cached leagues")
        }
}
