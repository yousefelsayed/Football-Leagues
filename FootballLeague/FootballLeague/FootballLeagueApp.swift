//
//  FootballLeagueApp.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

@main
struct FootballLeagueApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
