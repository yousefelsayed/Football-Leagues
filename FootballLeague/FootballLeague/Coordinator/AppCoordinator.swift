//
//  AppCoordinator.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 12/09/2023.
//

import Foundation
import SwiftUI


class AppCoordinator: ObservableObject {
    @Published var currentView: AnyView?
    
  
    
    func navigateToLeaguesView() -> AnyView {
        let repo = LeaguesRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeaguesUseCase(repository: repo)
        let leaguesViewModel = LeaguesViewModel(leaguesUseCase: useCase)
        
        return AnyView(LeaguesView(viewModel: leaguesViewModel))
    }
    
    func navigateToLeagueTeamsView(league: League) -> AnyView {
        let repo = LeagueTeamsRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeagueTeamsUseCase(repository: repo)
        let leagueTeamsViewModel = LeagueTeamsViewModel(leaguesUseCase: useCase, league: league)
        
        return AnyView(TeamsView(league: league, viewModel: leagueTeamsViewModel))
    }
}
