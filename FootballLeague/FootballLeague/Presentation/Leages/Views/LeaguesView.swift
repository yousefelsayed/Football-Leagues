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
    @EnvironmentObject var coordinator: AppCoordinator

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
                    Button(action: {
                        // Set the selected league when tapped
                        selectedLeague = league

                    }) {
                        LeagueRaw(league: league)
                    }
                    
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
    
    func navigateToLeagueTeamsView(league: League) -> some View {
        let repo = LeagueTeamsRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeagueTeamsUseCase(repository: repo)
        let leagueTeamsViewModel = LeagueTeamsViewModel(leaguesUseCase: useCase, league: league)
        
       return TeamsView(league: league, viewModel: leagueTeamsViewModel)
    }
}

