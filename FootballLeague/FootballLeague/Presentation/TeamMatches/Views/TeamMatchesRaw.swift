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
        VStack {
            switch MatchStatus(rawValue: match.matchStatus) {
            case .timed, .scheduled:
                VStack {
                    Spacer()
                        .frame(height: 5)
                    HStack(){
                        Spacer()
                        Text("\(match.matchDate.convertDateString() ?? "")")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        
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
                        
                        Spacer()
                        VStack {
                            Spacer()
                            Text("Scheduled")
                                .font(.system(size: 14))
                                .bold()
                            Spacer()
                                .frame(height: 8)
                            Text("\(match.matchDate.convertDateString() ?? "")")
                                .font(.system(size: 12))
                            Spacer()
                        }
                        
                        Spacer()
                        
                        
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
                        
                        
                    }
                    .frame(height: 60)
                }
            case .played:
                HStack {
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
                    
                    Spacer()
                    
                    
                    VStack {
                        Spacer()
                        Text("\(match.homeTeamScore):\(match.awayTeamScore)")
                            .font(.system(size: 14))
                        Spacer()
                    }
                    
                    Spacer()
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
                    
                }
                
            default:
                EmptyView()
            }
            
            
            
        }
    }
    
}
