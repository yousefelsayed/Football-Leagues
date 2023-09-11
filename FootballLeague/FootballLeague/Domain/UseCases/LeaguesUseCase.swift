//
//  LeaguesDataUseCase.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 11/09/2023.
//

import Foundation


protocol LeaguesDataUseCase {
    func fetchData() async throws -> ResultCallback<LeaguesResponse>
}


class LeaguesUseCase: LeaguesDataUseCase {

    
    private let repository: LeaguesDataRepository
    
    init(repository: LeaguesDataRepository) {
        self.repository = repository
    }
    
    
    func fetchData() async throws -> ResultCallback<LeaguesResponse> {
        return try await repository.getLeagues()
    }
    
    
}
