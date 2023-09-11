//
//  LeaguesView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

struct LeaguesView: View {
    var leagues = [League(leagueId: 0, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100"),League(leagueId: 2, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100"),League(leagueId: 1, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100")]
    
    @StateObject private var viewModel: LeaguesViewModel

       init(viewModel: LeaguesViewModel) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
    
    var body: some View {
        renderLeaguesList()
    }
    
  
    
    fileprivate func renderLeaguesList() -> some View{
        List{
            ForEach(viewModel.leagues, id:\.self){ league in
                LeagueRaw(league: league)
            }
        }
        .onAppear(perform: viewModel.getLeagues )
        .navigationTitle("Football Leagues")
    }
    
}

