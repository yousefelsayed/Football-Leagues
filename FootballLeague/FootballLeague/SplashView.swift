//
//  SplashView.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 16/09/2023.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    var body: some View {
        ZStack {
            Color.white
            if isActive {
                LeaguesConfugurator.configureLeaguesView()
                
            } else {
       
                Image("splashIcon")
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
    }
}
