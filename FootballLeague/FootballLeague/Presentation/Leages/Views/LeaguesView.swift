//
//  LeaguesView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

struct LeaguesView: View {
    
    @StateObject private var viewModel: LeaguesViewModel
    @State private var selectedLeague: League?
    
    init(viewModel: LeaguesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        renderLeaguesList()
    }
    
    fileprivate func renderLeaguesList() -> some View{
        ZStack {
            NavigationView {
                List(viewModel.leagues,id:\.id ) { league in
                    LeagueRaw(league: league,isSelectable: true)
                }
                .navigationTitle("Football Leagues")
                .listStyle(PlainListStyle())
            }.onAppear(perform: {viewModel.getLeagues()})
            
            if (viewModel.isLoading && viewModel.leagues.isEmpty) {
                ProgressView()
            }
        }
    }
}

