//
//  LeaguesViewModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 11/09/2023.
//

import Foundation


class LeaguesViewModel: ObservableObject {
    
    
    private let leaguesUseCase: LeaguesDataUseCase
    
    @Published var leagues: [League] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    init(leaguesUseCase: LeaguesDataUseCase) {
        self.leaguesUseCase = leaguesUseCase
    }
    
    
    func getLeagues() {
        Task {            
            do {
                let resultResponse = try await leaguesUseCase.fetchData()
                switch resultResponse {
                    
                case .success(let response):
                    //TODO: - map leagues response to leagues
                    break
                    
                case .failure(let error):
                    throw error
                }
            } catch {
                print("Error fetching leagues: \(error)")

            }
        }
    }
    
}

