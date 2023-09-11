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

