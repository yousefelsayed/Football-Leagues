//
//  LeaguesRepository.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation


class LeaguesRepository: LeaguesDataRepository {

    
    
    private let networkService: LeaguesURLSessionsNetworkService
    
    init(networkService: LeaguesURLSessionsNetworkService) {
        self.networkService = networkService
    }
    
    //MARK: - get leagues response and return complition
    func getLeagues(completion: @escaping (Result<LeaguesResponse, NetworkError>) -> Void) {
        networkService.fetchData { result in
            completion(result)
        }
    }

}
