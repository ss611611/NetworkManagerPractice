//
//  CatAPIManager+Env.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import SwiftUI

struct CatAPIMangerKey: EnvironmentKey {
    static var defaultValue: CatAPIManager = .shared
}

extension EnvironmentValues {
    var apiManager: CatAPIManager {
        get { self[CatAPIMangerKey.self] }
        set { self[CatAPIMangerKey.self] = newValue }
    }
}
