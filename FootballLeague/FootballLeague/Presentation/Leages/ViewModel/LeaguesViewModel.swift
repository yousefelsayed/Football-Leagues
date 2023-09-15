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
            // Show the progress indicator
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            // First, try to fetch cached leagues
            await getCachedLeagues()
            
            // If there are no cached leagues, fetch from the server
            await getLeaguesFromServer()
            
            
            // Hide the progress indicator
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
    
    func getLeaguesFromServer() async {
        do {
            let resultResponse = try await leaguesUseCase.fetchData()
            switch resultResponse {
                
            case .success(let response):
                
                let leagues = response.competitions?.compactMap({ competition in
                    return League(competition)
                })
                let sortedLeagues = leagues?.sorted{ $0.leagueName < $1.leagueName} ?? []

                DispatchQueue.main.async {
                    self.leagues = sortedLeagues
                }
                
                try leaguesUseCase.saveCurrentLeagues(Leagues(leagues: sortedLeagues))
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func getCachedLeagues() async {
        do {
            let result =  try await leaguesUseCase.getCachedLeagues()
            switch result {
            case .success(let cachedLeagues):
                DispatchQueue.main.async {
                    self.leagues = cachedLeagues.filter({$0.leagueId != 0})
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}

