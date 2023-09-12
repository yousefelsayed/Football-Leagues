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
        VStack {
            HStack{
                if let imageURL = URL(string: league.leagueLogo) {
                    KFImage.url(imageURL)
                        .placeholder({ _ in
                            Image(systemName:"photo")
                        })
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding()
                    
                }
                
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text(league.leagueName)
                        .font(.subheadline)
                    
                    
                    HStack(spacing: 40) {
                        VStack(spacing: 5) {
                            Image("team")
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text(league.numberOfTeams)
                                .font(.subheadline)
                            
                            
                            
                            
                        }
                        
                        VStack(spacing: 5) {
                            
                            Image("footballIcon")
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text(league.numberOfGames)
                                .font(.subheadline)
                        }
                        Spacer()
                        
                    }
                }
            }
        }
    
    }
    
}


