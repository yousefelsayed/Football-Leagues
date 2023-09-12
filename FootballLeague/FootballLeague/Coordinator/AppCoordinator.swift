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
    
    init() {
        navigateToLeaguesView()
    }
    
    func navigateToLeaguesView() {
        let repo = LeaguesRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
        let useCase = LeaguesUseCase(repository: repo)
        let leaguesViewModel = LeaguesViewModel(leaguesUseCase: useCase)
        
        currentView = AnyView(LeaguesView(viewModel: leaguesViewModel))
    }
    
}
