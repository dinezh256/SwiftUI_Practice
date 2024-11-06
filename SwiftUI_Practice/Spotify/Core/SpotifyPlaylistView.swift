//
//  SpotifyPlaylistView.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 21/06/24.
//

import SwiftUI

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    
    var body: some View {
        ZStack {
            Color.spotifyBlack
                .ignoresSafeArea()

            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        title: product.title,
                        subtitle: product.description ,
                        imageName: product.firstImage ,
                        height: 250
                    )
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpotifyPlaylistView()
}
