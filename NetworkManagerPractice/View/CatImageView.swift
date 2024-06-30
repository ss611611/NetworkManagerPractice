//
//  CatImageView.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import SwiftUI

struct CatImageView: View {
    @State private var phase: AsyncImagePhase
    @State private var isLoading: Bool = false
    private var session: URLSession = .imageSession
    
    private let catImage: CatImageViewModel
    private let isFavourited: Bool
    private var onDoubleTap: () async -> Void
    
    
    init(_ catImage: CatImageViewModel, isFavourited: Bool, session: URLSession = .imageSession, onDoubleTap: @escaping () async -> Void) {
        self.session  = session
        self.catImage = catImage
        self.isFavourited = isFavourited
        self.onDoubleTap = onDoubleTap
        
        let urlRequest = URLRequest(url: catImage.url)
        if let data = session.configuration.urlCache?.cachedResponse(for: urlRequest)?.data,
           let uiImage = UIImage(data: data) {
            _phase = .init(wrappedValue: .success(.init(uiImage: uiImage)))
        } else {
            _phase = .init(wrappedValue: .empty)
        }
    }
    
    private var imageHeight: CGFloat? {
        guard let width = catImage.width, let height = catImage.height else {
            return nil
        }
        let scale = UIScreen.main.bounds.maxX / width
        return height * scale
    }
    
    var body: some View {
        Group {
            switch phase {
                case .empty:
                    ProgressView()
                        .controlSize(.large)
                        .onAppear(perform: load)
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "heart.fill")
                                .scaleEffect(isFavourited ? 1 : 0.0001)
                                .font(.largeTitle)
                                .padding()
                                .foregroundStyle(.pink)
                        }
                        .opacity(isLoading ? 0.5 : 1)
                        .animation(.default, value: isLoading)
                        .overlay(alignment: .topTrailing) {
                            if isLoading {
                                ProgressView()
                                    .controlSize(.large)
                                    .padding()
                            }
                        }
                        .onTapGesture(count: 2) {
                            Task {
                                isLoading = true
                                await onDoubleTap()
                                isLoading = false
                            }
                        }
                        .disabled(isLoading)
                    
                case .failure:
                    Color(.systemGray6)
                    .overlay {
                        VStack {
                            Text("圖片無法顯示")
                            Button("重試") {
                                phase = .empty
                            }
                        }
                    }
                    
                    
                @unknown default:
                    fatalError("This has not been implemented.")
            }
        }
        .animation(.interactiveSpring(), value: isFavourited)
        .frame(maxWidth: .infinity, minHeight: 200)
        .frame(height: imageHeight)
    }
}


private extension CatImageView {
    func load() {
        Task {
            do {
                let urlRequest = URLRequest(url: catImage.url)
                let data = try await session.data(for: urlRequest)
                guard let uiImage = UIImage(data: data) else {
                    throw URLSession.APIError.invalidData
                }
                
                phase = .success(.init(uiImage: uiImage))
            } catch {
                phase = .failure(error)
            }
        }
    }
}


struct CatImageView_Previews: PreviewProvider, View {
    @State private var isFavourited: Bool = false
    
    var body: some View {
        CatImageView([CatImageViewModel].stub.first!, isFavourited: isFavourited) {
            try? await Task.sleep(for: .seconds(1))
            isFavourited.toggle()
        }
    }
    
    static var previews: some View {
        Self()
    }
}
