//
//  LeaguesNetworkService.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

typealias ResultCallback<T> = Result<T, NetworkError>



struct LeaguesEndPoint: Endpoint {
    var path: String {
        return "competitions"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
