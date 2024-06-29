//
//  View+Preview.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/28.
//

import SwiftUI

extension View {
    @MainActor func previewEnvironmentObject(manager: CatAPIManager = .preview) -> some View {
        environmentObject(manager)
    }
}
