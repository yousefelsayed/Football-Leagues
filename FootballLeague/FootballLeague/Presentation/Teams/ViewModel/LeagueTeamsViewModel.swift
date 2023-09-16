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
    var sortedTeams: [LeagueTeamsIModel]?
    var league: League?
    
    init(leaguesUseCase: LeagueTeamsDataUseCase, league: League) {
        self.leagueTeamUseCase = leaguesUseCase
        self.league = league
    }
    
    
    func getLeagueTeams() {
        if self.teams.isEmpty {
            teams =  [LeagueTeamsIModel]()
        }
        Task {
            // Show the progress indicator
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            // First, try to fetch cached leagues
            await getCachedLeagueTeams(leagueCode: self.league?.leagueCode)
            
            // If there are no cached leagues, fetch from the server
            await getLeagueTeamsFromServer(self.league?.leagueCode ?? "")
            
            
            // Hide the progress indicator
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
    
    func getLeagueTeamsFromServer(_ leagueCode: String) async {
        do {
            let resultResponse = try await leagueTeamUseCase.getLeagueTeams(leagueCode)
            switch resultResponse {
                
            case .success(let response):
                
                let teams = response.teams?.compactMap({ team in
                    return LeagueTeamsIModel(team,competition: response.competition)
                })
                let sortedTeams = teams?.sorted{($0.teamName.lowercased()) < ($1.teamName.lowercased())} ?? []
               

                DispatchQueue.main.async {
                    self.teams = sortedTeams
                }
                self.sortedTeams = sortedTeams
                try leagueTeamUseCase.cacheLeagueTeamsData( LeagueTeams(teams: teams ?? []), leagueCode: leagueCode)
                
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
    
    func getCachedLeagueTeams(leagueCode: String?) async {
        do {
            guard let leagueCode = leagueCode else {
                throw CachDataError.onError("Error no league code to retreive cached teams")
            }
            let result =  try await leagueTeamUseCase.getCachedLeagueTeams(leagueCode)
            switch result {
            case .success(let cachedLeagueTeams):
                DispatchQueue.main.async {
                    self.teams = cachedLeagueTeams.sorted(by: {($0.teamName.lowercased()) < ($1.teamName.lowercased())})
                }
                self.sortedTeams = cachedLeagueTeams.sorted(by: {($0.teamName.lowercased()) < ($1.teamName.lowercased())})
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    
}

