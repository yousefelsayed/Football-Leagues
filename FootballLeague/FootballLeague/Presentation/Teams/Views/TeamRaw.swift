//
//  TeamRaw.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 13/09/2023.
//

import SwiftUI
import Kingfisher

struct TeamRaw: View {
    let team: LeagueTeamsIModel

    var body: some View {
        
        HStack{
            if let imageURL = URL(string: team.teamLogo) {
                KFImage.url(imageURL)
                    .startLoadingBeforeViewAppear()
                    .placeholder({ _ in
                        Image(systemName:"photo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .onAppear()
                    })
                    .resizable()
                    .frame(width: 40, height: 40)
                    .onAppear()
                    .padding()
                
            }
            
            Text(team.teamName)
                .font(.subheadline)
            
            Spacer()
            
        }
    }
}
