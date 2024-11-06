//
//  SpotifyCategoryCell.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 15/06/24.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    
    var title: String = "Music"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
            .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 20) {
            SpotifyCategoryCell(isSelected: true)
            SpotifyCategoryCell(title: "All", isSelected: false)
        }
        
    }
    
}
