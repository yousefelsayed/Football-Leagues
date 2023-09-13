//
//  TeamsView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import SwiftUI

struct TeamsView: View {
    var league: League
    @StateObject var viewModel: LeagueTeamsViewModel
    
    init(league: League, viewModel: LeagueTeamsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.league = league
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    LeagueRaw(league: league,isSelectable: false)
                }
                
                Section(header: Text("Teams")) {
                    ForEach(viewModel.teams, id:\.teamId){ team in
                        TeamRaw(team: team)

                    }
                }
                if (viewModel.isLoading && viewModel.teams.isEmpty) {
                    ProgressView()
                }
            }

            .onAppear {
                viewModel.getLeagueTeams()
            }

            
        }
        .navigationTitle(league.leagueName)
    }
}
    

