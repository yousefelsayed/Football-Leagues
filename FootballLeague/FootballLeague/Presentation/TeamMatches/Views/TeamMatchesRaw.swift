//
//  TeamMatchesRaw.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import SwiftUI
import Kingfisher

struct TeamMatchesRaw: View {
    let match: TeamMatchesIModel

    var body: some View {
        
        HStack{
            VStack {
                if let imageURL = URL(string: match.homeTeamLogo) {
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
            }
            .padding()
            
            Spacer()
            
            VStack {
                switch MatchStatus(rawValue: match.matchStatus) {
                case .played:
                    Text("\(match.homeTeamScore):\(match.awayTeamScore)")
                case .scheduled:
                    Text("Scheduled")
                        .font(.subheadline)
                        .bold()
                    Text("\(match.homeTeamScore):\(match.awayTeamScore)")
                        .font(.subheadline)

                default:
                    EmptyView()
                }
            }
            Spacer()
            VStack {
                switch MatchStatus(rawValue: match.matchStatus) {
                case .played:
                    Text("\(match.matchDate.convertStringToDate())")
                    if let imageURL = URL(string: match.awayTeamLogo) {
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
                case .scheduled:
                    if let imageURL = URL(string: match.awayTeamLogo) {
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
                    
                default:
                    EmptyView()

                }
            }
            .padding()
        
     
         
        }
    }
}

