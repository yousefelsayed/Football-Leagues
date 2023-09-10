//
//  LeagueRaw.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

struct LeagueRaw: View {
    let league: League
    
    var body: some View {
        HStack {
            if let imageURL = URL(string: league.leagueLogo) {
                if #available(iOS 15.0, *) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            Image("placeholder-image")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                        case .success(let image):
                            // Display the loaded image
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                            
                        case .failure(let error):
                            // Handle image loading error
                            Text("Error: \(error.localizedDescription)")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                    Image(imageURL)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            } else {
                Image("placeholder-image")
                    .resizable()
                    .frame(width: 40, height: 40)
            }

            VStack(alignment: .leading) {
                Text(league.leagueName)
                    .font(.headline)
                Text("Teams: \(league.numberOfTeams)")
                    .font(.subheadline)
                Text("Games: \(league.numberOfGames)")
                    .font(.subheadline)
            }
        }
    }
    
}

