//
//  APIEndPoint.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var base: String {
        return "https://api.football-data.org/v4/"
    }
    
    var header: [String:String]? {
        return ["X-Auth-Token":"d9367a4c6c0e421eaaf871ec900c83d4"]
    }
}
