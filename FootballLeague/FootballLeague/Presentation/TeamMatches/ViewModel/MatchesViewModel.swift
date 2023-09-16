//
//  MatchesViewModel.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation

class TeamMatchesViewModel: ObservableObject {
    
    
    private let teamMatchesUseCase: TeamMatchesDataUseCase
    
    @Published var matches: [TeamMatchesIModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    var team: LeagueTeamsIModel
    var sortedMatches: [TeamMatchesIModel] = []

    init(teamMatchUseCase: TeamMatchesDataUseCase, team: LeagueTeamsIModel) {
        self.teamMatchesUseCase = teamMatchUseCase
        self.team = team
    }
    
    
    func getTeamMatches() {
      
        Task {
            // Show the progress indicator
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            // First, try to fetch cached matches
            await getCachedTeamMatches(teamId: team.teamId)
            
            // If there are no cached matches, fetch from the server
            await getTeamMatchesFromServer(self.team.teamId)
            
            
            // Hide the progress indicator
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
    
    func getTeamMatchesFromServer(_ teamId: Int) async {
        do {
            let resultResponse = try await teamMatchesUseCase.getTeamMatches(teamId)
            switch resultResponse {
                
            case .success(let response):
                
                let teamMatches = response.matches?.compactMap({ match in
                    return TeamMatchesIModel(match: match)
                })
        

                let sortedMatches = teamMatches?.sorted(by: {($0.matchDate.convertStringToDate() == $1.matchDate.convertStringToDate())})
                self.sortedMatches = sortedMatches ?? []
                DispatchQueue.main.async {
                    self.matches = sortedMatches ?? []
                }

                try teamMatchesUseCase.cacheTeamMatches(TeamMatches(matches: sortedMatches ?? []), teamId: teamId)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getCachedTeamMatches(teamId: Int?) async {
        do {
            guard let teamId = teamId else {
                throw CachDataError.onError("Error no team id to retreive cached matches")
            }
            let result =  try await teamMatchesUseCase.getCachedTeamMatches(teamId)
            switch result {
            case .success(let cachedMatches):
                DispatchQueue.main.async {
                    self.matches = cachedMatches.sorted(by: {($0.matchDate.convertStringToDate() == $1.matchDate.convertStringToDate())})
                }
                self.sortedMatches = cachedMatches.sorted(by: {($0.matchDate.convertStringToDate() == $1.matchDate.convertStringToDate())})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}

