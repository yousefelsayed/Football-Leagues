//
//  TeamsUseCaseTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest
@testable import FootballLeague

final class TeamsUseCaseTests: XCTestCase {

    var sut: LeagueTeamsUseCase!
    var repository: TeamsRepositoryMocks!

    override func setUpWithError() throws {
        repository = TeamsRepositoryMocks()
        sut = LeagueTeamsUseCase(repository: repository)
    }
    
    
    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }
    
    func test_getTeamsData_Should_Return_Success() async throws {
        
        repository.isSuccess = true

        let result = try await sut.getLeagueTeams("BRA")
        
        switch result {
            
        case .success(let teamsResponse):
            XCTAssertNotNil(teamsResponse)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }

    
    func test_getLeagueTeamsData_Should_Return_Failure() async throws {
        repository.isSuccess = false
        
        let result = try await sut.getLeagueTeams("BRA")
        
        switch result {
            
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        }
    }
    
    func test_getLeagueTeamsCachedData_Should_Return_Success() async throws {
        repository.isSuccess = true
        
        let result = try await sut.getCachedLeagueTeams("BRA")
        
        
        switch result {
            
        case .success(let teams):
            XCTAssert(teams.count > 0)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }
    
    
    func test_getTeamsCachedData_Should_Return_Failure() async throws {
        repository.isSuccess = false
        
        let result = try await sut.getCachedLeagueTeams("BRA")

        
        switch result {
            
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No Cached data for league code for this team")
        }
    }
    
    func test_cacheTeam_OnSucess() async throws {
        repository.isSuccess = true
        
        let result = try await repository.getCachedLeagueTeams("BRA")
        
        switch result {
            
        case .success(let teams):
            try sut.cacheLeagueTeamsData(LeagueTeams(teams: teams), leagueCode: "BRA")
            XCTAssertTrue(repository.cacheTeamsDataCalled)
        case .failure(_):
            XCTFail("Caching teams should not throw an error")
            
        }
    }
    
    func test_cacheLeagues_OnFailure() async throws {
        repository.isSuccess = false

        let result = try await repository.getCachedLeagueTeams("BRA")
        switch result {
            
        case .success(_):
            XCTFail("Caching teams should not enter success")
        case .failure(_):
            XCTAssertFalse(repository.cacheTeamsDataCalled)
            
        }
    }

}
