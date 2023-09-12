//
//  ContentView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        coordinator.currentView
    }
}
