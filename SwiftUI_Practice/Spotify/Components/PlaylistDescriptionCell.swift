//
//  PlaylistDescriptionCell.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 21/06/24.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    
    var descriptionText: String = Product.mock.description
    
    var body: some View {
        Text(descriptionText)
            .foregroundStyle(Color.spotifyWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
    }
}
