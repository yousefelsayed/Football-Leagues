//
//  TeamMatchesView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import SwiftUI

struct TeamMatchesView: View {
    var team: LeagueTeamsIModel
    @StateObject var viewModel:TeamMatchesViewModel
    
    init(team: LeagueTeamsIModel, viewModel: TeamMatchesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.team = team
    }
    
    var body: some View {
        List {
            Section {
                TeamRaw(team: team,isSelectable: false)
            }
            
            Section(header: Text("Matches")) {
                ForEach(viewModel.matches, id:\.id){ match in
                    TeamMatchesRaw(match: match)
                    
                }
            }
            
            if (viewModel.isLoading && viewModel.matches.isEmpty) {
                ProgressView()
            }
        }
        
        .onAppear { viewModel.getTeamMatches() }
        .navigationTitle(team.teamShortName)
    }
}
