//
//  MatchesUseCaseTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 17/09/2023.
//

import XCTest
@testable import FootballLeague

final class MatchesUseCaseTests: XCTestCase {
    var sut: TeamMatchesUseCase!
    var repository: MatchesRepositoryMocks!

    override func setUpWithError() throws {
        repository = MatchesRepositoryMocks()
        sut = TeamMatchesUseCase(repository: repository)
    }
    
    
    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }
    
    func test_getMatchesData_Should_Return_Success() async throws {
        
        repository.isSuccess = true

        let result = try await sut.getTeamMatches(123)
        
        switch result {
        case .success(let matchesResponse):
            XCTAssertNotNil(matchesResponse)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }

    
    func test_getTeamMatchesData_Should_Return_Failure() async throws {
        
        repository.isSuccess = false
        
        let result = try await sut.getTeamMatches(123)
        
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        }
    }
    
    func test_getTeamMatchesCachedData_Should_Return_Success() async throws {
        repository.isSuccess = true
        
        let result = try await sut.getCachedTeamMatches(123)
        
        
        switch result {
        case .success(let matches):
            XCTAssert(matches.count > 0)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }
    
    
    func test_getTeamMatchesCachedData_Should_Return_Failure() async throws {
        repository.isSuccess = false
        
        let result = try await sut.getCachedTeamMatches(123)

        
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No Cached data for team id")
        }
    }
    
    func test_cacheTeamMatches_OnSucess() async throws {
       
        repository.isSuccess = true
        
      
        
        let result = try await repository.getCachedTeamMatches(123)
        
        switch result {
            
        case .success(let matches):
            try sut.cacheTeamMatches(TeamMatches(matches: matches), teamId: 123)
            XCTAssertTrue(repository.cacheMatchesDataCalled)
        case .failure(_):
            XCTFail("Caching matches should not throw an error")
            
        }
    }
    
    func test_cacheLeagues_OnFailure() async throws {
        repository.isSuccess = false

        let result = try await repository.getCachedTeamMatches(123)
        switch result {
            
        case .success(_):
            XCTFail("Caching matches should not enter success")
        case .failure(_):
            XCTAssertFalse(repository.cacheMatchesDataCalled)
            
        }
    }

}
