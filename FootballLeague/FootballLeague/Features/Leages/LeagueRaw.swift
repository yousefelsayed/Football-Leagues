//
//  LeagueRaw.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI
import Kingfisher

struct LeagueRaw: View {
    let league: League
    
    var body: some View {
        HStack {
            if let imageURL = URL(string: league.leagueLogo) {
                KFImage.url(imageURL)
                     .placeholder({ _ in
                         Image(systemName:"placeholder-image")
                     })
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


