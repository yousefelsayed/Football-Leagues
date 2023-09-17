//
//  LeaguesRepositoryTests.swift
//  FootballLeagueTests
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import XCTest
@testable import FootballLeague

final class LeaguesRepositoryTests: XCTestCase {
    
    var sut: LeaguesRepositoryMocks?
    
    func test_getLeagues_onSucess() async throws {
        let sut = LeaguesRepositoryMocks()
        let result = try await sut.getLeagues()
        
        switch result {
            
        case let .success(leagues):
            XCTAssertNotNil(leagues)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getLeagues_onInvalidResponse_OnFailure() async throws {
        let sut = LeaguesRepositoryMocks()
        let result = try await sut.getFailedLeagues()
        
        switch result {
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, FootballLeague.NetworkError.invalidResponse.localizedDescription)
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_getCachedLeagues_onSucess() async throws {
        let sut = LeaguesRepositoryMocks()
        let result = try await sut.getCachedLeagues()
        
        switch result {
            
        case let .success(leagues):
            XCTAssertNotNil(leagues)
        default:
            XCTFail("Request should have succeded")
        }
    }
    
    func test_getCachedLeagues_onNoDataFound_OnFailure() async throws {
        let sut = LeaguesRepositoryMocks()
        let result = try await sut.getFailedCachedLeagues()
        
        switch result {
            
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "No data found")
        default:
            XCTFail("Request should have failed")
        }
    }
    
    
    func test_cacheLeagues_OnSucess() async throws {
        let sut = LeaguesRepositoryMocks()
        
        do {
            try await sut.cacheLeaguesDataSuccess()
            XCTAssertTrue(sut.cacheLeaguesDataCalled)
        } catch {
            XCTFail("Caching leagues should not throw an error")
        }
    }
    
    func test_cacheLeagues_OnFailure() async throws {
        let sut = LeaguesRepositoryMocks()
        XCTAssertThrowsError(try sut.cacheLeaguesDataFailed())
    }
}
