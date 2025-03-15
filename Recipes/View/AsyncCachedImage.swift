//
//  AsyncCachedImage.swift
//  Recipes
//
//  Created by Yang Chen on 3/14/25.
//

import SwiftUI

struct AsyncCachedImage<Content>: View where Content : View {
    let url: URL
    let content: (AsyncImagePhase) -> Content
    @State var phase: AsyncImagePhase = .empty
    
    init(url: URL, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.content = content
    }
    
    var body: some View {
        content(phase)
            .task {
                do {
                    let image = try await ImageManager().fetchImage(from: url)
                    phase = .success(Image(uiImage: image))
                }
                catch {
                    phase = .failure(error)
                }
            }
    }
}
