//
//  LeaguesView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 10/09/2023.
//

import SwiftUI

struct LeaguesView: View {
    var leagues = [League(leagueId: 0, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100"),League(leagueId: 2, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100"),League(leagueId: 1, leagueName: "Egyptian league", leagueCode: "0", leagueLogo: "https://crests.football-data.org/762.png", leagueAreaName: "test", numberOfTeams: "20", numberOfGames: "100")]
    
    var body: some View {
        NavigationView {
            List(leagues, id: \.leagueId) { league in
                LeagueRaw(league: league)
            }
        }
        .navigationTitle("Football Leagues")
    }
}

struct LeaguesView_Previews: PreviewProvider {
    static var previews: some View {
        LeaguesView()
    }
}
