//
//  LeaguesView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

struct LeaguesView: View {
 
    
    @StateObject private var viewModel: LeaguesViewModel

       init(viewModel: LeaguesViewModel) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
    
    var body: some View {
        NavigationView {
            renderLeaguesList()
        }
    }
    
  
    
    fileprivate func renderLeaguesList() -> some View{
        ZStack {
            List{
                ForEach(viewModel.leagues, id:\.id){ league in
                    LeagueRaw(league: league)
                }
            }
            .onAppear(perform: viewModel.getLeagues )
            .navigationTitle("Football Leagues")
            .listStyle(PlainListStyle())

            if (viewModel.isLoading && viewModel.leagues.isEmpty) {
                ProgressView()
            }
        }
        
    }
    
}

