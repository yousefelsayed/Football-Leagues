//
//  LeaguesNetworkService.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

protocol LeaguesURLSessionsNetworkService {
    typealias ResultCallback<T> = (Result<T, NetworkError>) -> Void
    func fetchData(completion: @escaping ResultCallback<LeaguesResponse>)
}

struct LeaguesEndPoint: Endpoint {
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}

class LeaguesNetworkService: URLSessionNetworkService {
    
    private let networkService: URLSessionNetworkService
    
    init(networkService: URLSessionNetworkService) {
        self.networkService = networkService
    }
    
    //MARK: - Get Leagues API call
    func fetchData(completion: @escaping ResultCallback<LeaguesResponse>) {

        let endPoint = LeaguesEndPoint()
        
        networkService.performRequest(endPoint: endPoint) { (result: Result<LeaguesResponse, NetworkError>) in
            switch result {
            case .success(let leaguesResponse):
                completion(.success(leaguesResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
