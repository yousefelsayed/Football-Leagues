//
//  AppCoordinator.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 12/09/2023.
//

import Foundation
import SwiftUI



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

final class TeamMatchesCoordinator {
    
    public static func destinationForTappedTeam(team: LeagueTeamsIModel) -> some View {
        return TeamMatchesConfugurator.configureTeamMatchesView(team: team)
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

final class TeamMatchesConfugurator {
    
    public static func configureTeamMatchesView(team: LeagueTeamsIModel) -> TeamMatchesView {
        
        let repo = TeamMatchesRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = TeamMatchesUseCase(repository: repo)
        let teamMatchesViewModel = TeamMatchesViewModel(teamMatchUseCase: useCase, team: team)
        
        return TeamMatchesView(team: team, viewModel: teamMatchesViewModel)
    }
}
