//
//  HomeScreen.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import SwiftUI

struct HomeScreen: View {
    @State private var tab: Tab = .images
    
    var body: some View {
        TabView(selection: $tab) {
            CatImageScreen()
                .tabItem { Label("Home", systemImage: "house") }
                .tag(Tab.images)
            
            FavoriteScreen()
                .tabItem { Label("Favorite", systemImage: "heart.fill") }
                .tag(Tab.favorites)
        }
    }
}


private extension HomeScreen {
    enum Tab {
        case images, favorites
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .previewEnvironmentObject(manager: .preview)
    }
}
