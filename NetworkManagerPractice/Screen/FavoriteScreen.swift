//
//  FavoriteScreen.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import SwiftUI

enum FavoriteLoadingState: Equatable {
    case loading(page: Int)
    case success(nextPage: Int?)
    case fail(retryPage: Int)
}

struct FavoriteScreen: View {
    @EnvironmentObject private var apiManager: CatAPIManager
    @State private var loadingState: FavoriteLoadingState = .loading(page: 0)
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("我的最愛")
                .font(.largeTitle.bold())
            
            ScrollView {
                if apiManager.favorites.isEmpty && loadingState == .success(nextPage: nil) {
                    favoriteFeatureHintText
                }
                
                LazyVStack{
                    favoriteList
                    
                    Group {
                        switch loadingState {
                        case .loading(let page):
                            ProgressView()
                                .controlSize(.large)
                                .onAppear { loadFavorite(page: page) }
                        case .success(let nextPage?):
                            ProgressView()
                                .controlSize(.large)
                                .onAppear { loadingState = .loading(page: nextPage)}
                                
                        case .fail(let retryPage):
                            buildRetryButton(retryPage: retryPage)
                            
                        default:
                            EmptyView()
                        }
                    }.frame(minHeight: 100)
                }
            }
        }
        .animation(.spring(), value: apiManager.favorites)
        .alert(errorMessage: $errorMessage)
    }
}

private extension FavoriteScreen {
    func loadFavorite(page: Int) {
        Task {
            loadingState = await apiManager.getFavorites(page: page, limit: 5)
        }
    }
}

// MARK: subviews
private extension FavoriteScreen {
    var favoriteFeatureHintText: some View {
        Text("雙擊圖片即可新增到最愛喲 😊")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(x: apiManager.favorites.isEmpty ? 0 : -UIScreen.main.bounds.maxX)
            .font(.title3)
            .padding()
    }
    
    var favoriteList: some View {
        ForEach(apiManager.favorites, id: \.imageID) { favoriteItem in
            CatImageView(.init(favoriteItem: favoriteItem), isFavourited: true) {
                do {
                    try await apiManager.removeFromFavorite(id: favoriteItem.id)
                } catch {
                    errorMessage = "無法移除最愛項目，請確認網路狀態後再重試。"
                }
            }.transition(.slide)
        }
    }
    
    func buildRetryButton(retryPage: Int) -> some View {
        HStack {
            Text("載入最愛資料未完成，\n請確認網路狀態後再重試。")
            Button("繼續") {
                loadingState = .loading(page: retryPage)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        }
    }
}

struct FavoriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        let managerWithDefaultFavorites = CatAPIManager(getData: \.stub)
        FavoriteScreen()
            .previewEnvironmentObject(manager: managerWithDefaultFavorites)
    }
}
