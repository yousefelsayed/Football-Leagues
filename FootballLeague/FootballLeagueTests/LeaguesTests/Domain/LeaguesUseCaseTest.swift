//
//  LeaguesUseCaseTest.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest
@testable import FootballLeague


final class LeaguesUseCaseTest: XCTestCase {

    var sut: LeaguesUseCase!
    var repository: LeaguesRepositoryMocks!

    override func setUpWithError() throws {
        repository = LeaguesRepositoryMocks()
        sut = LeaguesUseCase(repository: repository)
    }
    
    
    override func tearDownWithError() throws {
        repository = nil
        sut = nil
    }

    
    func test_getLeaguesData_Should_Return_Success() async throws {
        
        repository.isSuccess = true

        let result = try await sut.fetchData()
        
        switch result {
        case .success(let leaguesResponse):
            XCTAssertNotNil(leaguesResponse)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }

    
    func test_getLeaguesData_Should_Return_Failure() async throws {
        
        repository.isSuccess = false
        
        let result = try await sut.fetchData()
        
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        }
    }
    
    func test_getLeaguesCachedData_Should_Return_Success() async throws {
        repository.isSuccess = true
        
        let result = try await sut.getCachedLeagues()
        
        
        switch result {
        case .success(let leagues):
            XCTAssert(leagues.count > 0)
        case .failure:
            XCTFail("Expected success, got failure")
        }
    }
    
    
    func test_getLeaguesCachedData_Should_Return_Failure() async throws {
        repository.isSuccess = false
        
        let result = try await sut.getCachedLeagues()
        
        
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No Data Found")
        }
    }
    
    func test_cacheLeagues_OnSucess() async throws {
       
        repository.isSuccess = true
        let result = try await repository.getCachedLeagues()
        
        switch result {
            
        case .success(let leagues):
            let leagues = Leagues(leagues: leagues)
            try sut.saveCurrentLeagues(leagues)
            XCTAssertTrue(repository.cacheLeaguesDataCalled)
        case .failure(_):
            XCTFail("Caching leagues should not throw an error")
            
        }
    }
    
    func test_cacheLeagues_OnFailure() async throws {
        repository.isSuccess = false

        let result = try await repository.getCachedLeagues()
        
        switch result {
            
        case .success(_):
            XCTFail("Caching leagues should not enter success")
        case .failure(_):
            XCTAssertFalse(repository.cacheLeaguesDataCalled)
            
        }
    }
}
