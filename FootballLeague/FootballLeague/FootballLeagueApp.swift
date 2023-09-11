//
//  FootballLeagueApp.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct FootballLeagueApp: App {

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            let repo = LeaguesRepository(networkService: URLSessionNetworkService(), coreDataManager: CoreDataManager.shared)
            let useCase = LeaguesUseCase(repository: repo)
            let leaguesViewModel = LeaguesViewModel(leaguesUseCase: useCase)
            LeaguesView(viewModel: leaguesViewModel)
        }
    }
}
