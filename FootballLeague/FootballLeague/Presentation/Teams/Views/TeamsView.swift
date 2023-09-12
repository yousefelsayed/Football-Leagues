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
         renderLeagueTeamsList()
     }
 }
 
    
    fileprivate func renderLeagueTeamsList() -> some View{
        ZStack {
            List{
                ForEach(viewModel.teams, id:\.id){ team in
                    Button(action: {
                        // Set the selected league when tapped

                    }) {
                        LeagueRaw(league: league)
                    }
                    
                }
            }
            .onAppear {
                viewModel.getLeagueTeams()
            }
            .navigationTitle("\(viewModel.league?.leagueName ?? "")")
            .listStyle(PlainListStyle())

            if (viewModel.isLoading && viewModel.teams.isEmpty) {
                ProgressView()
            }
        }
        
    }
}


