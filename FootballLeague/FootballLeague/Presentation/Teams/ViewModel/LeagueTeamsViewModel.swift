//
//  LeagueTeamsViewModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import Foundation


class LeagueTeamsViewModel: ObservableObject {
    
    
    private let leagueTeamUseCase: LeagueTeamsDataUseCase
    
    @Published var teams: [LeagueTeamsIModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    init(leaguesUseCase: LeagueTeamsDataUseCase) {
        self.leagueTeamUseCase = leaguesUseCase
    }
    
    
    func getLeagueTeams(_ leagueID: Int?) {
        Task {
            // Show the progress indicator
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            // First, try to fetch cached leagues
            await getCachedLeagueTeams(leagueID: leagueID)
            
            // If there are no cached leagues, fetch from the server
            await getLeagueTeamsFromServer(leagueID ?? 0)
            
            
            // Hide the progress indicator
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
    
    func getLeagueTeamsFromServer(_ leagueID: Int) async {
        do {
            let resultResponse = try await leagueTeamUseCase.getLeagueTeams(leagueID)
            switch resultResponse {
                
            case .success(let response):
                
                let teams = response.teams?.compactMap({ team in
                    return LeagueTeamsIModel(team)
                })
                let sortedTeams = teams?.sorted{($0.teamName.lowercased()) < ($1.teamName.lowercased())} ?? []
               

                DispatchQueue.main.async {
                    self.teams = sortedTeams
                }
                
                try leagueTeamUseCase.cacheLeagueTeamsData( LeagueTeams(teams: teams ?? []), leagueID: leagueID)
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func getCachedLeagueTeams(leagueID: Int?) async {
        do {
            guard let leagueID = leagueID else {
                throw CachDataError.onError("Error no league id to retreive cached teams")
            }
            let result =  try await leagueTeamUseCase.getCachedLeagueTeams(leagueID)
            switch result {
            case .success(let cachedLeagueTeams):
                DispatchQueue.main.async {
                    self.teams = cachedLeagueTeams
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

