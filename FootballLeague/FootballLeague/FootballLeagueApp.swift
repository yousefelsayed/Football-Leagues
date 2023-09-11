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
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            let repo = LeaguesRepository(networkService: URLSessionNetworkService())
            let useCase = LeaguesUseCase(repository: repo)
            let leaguesViewModel = LeaguesViewModel(leaguesUseCase: useCase)
            LeaguesView(viewModel: leaguesViewModel)
        }
    }
}
