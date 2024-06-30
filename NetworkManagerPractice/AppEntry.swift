//
//  NetworkManagerPracticeApp.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import SwiftUI

@main
struct NetworkManagerPracticeApp: App {
    init() {
        applyTabBarBackground()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(CatAPIManager.shared)
        }
    }
}

extension NetworkManagerPracticeApp {
    func applyTabBarBackground() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor  = .systemBackground.withAlphaComponent(0.3)
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
