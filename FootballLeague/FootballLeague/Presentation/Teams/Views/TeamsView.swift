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
     .navigationTitle(league.leagueName)
 }
 
    
    fileprivate func renderLeagueTeamsList() -> some View{
        ZStack {
            List{
                ForEach(viewModel.teams, id:\.teamId){ team in
                    Button(action: {
                        // Set the selected team when tapped

                    }) {
                        TeamRaw(team: team)
            
                    }
                    
                }
            }
            .onAppear {
                viewModel.getLeagueTeams()
            }
            .listStyle(PlainListStyle())

            if (viewModel.isLoading && viewModel.teams.isEmpty) {
                ProgressView()
            }
        }
        
    }
}


