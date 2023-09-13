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

final class LeaguesConfugurator {
    
    public static func configureLeaguesView() -> LeaguesView {
        
        let repo = LeaguesRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeaguesUseCase(repository: repo)
        let leaguesViewModel = LeaguesViewModel(leaguesUseCase: useCase)
        
        return LeaguesView(viewModel: leaguesViewModel)
    }
}

final class LeaguesCoordinator {
    
    public static func destinationForTappedLeague(league: League) -> some View {
        return LeagueTeamsConfugurator.configureLeagueTeamsView(league: league)
    }
}



final class LeagueTeamsConfugurator {
    
    public static func configureLeagueTeamsView(league: League) -> TeamsView {
        
        let repo = LeagueTeamsRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeagueTeamsUseCase(repository: repo)
        let leagueTeamsViewModel = LeagueTeamsViewModel(leaguesUseCase: useCase, league: league)
        
        return TeamsView(league: league, viewModel: leagueTeamsViewModel)
    }
}
