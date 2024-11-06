//
//  ImageTitleRowCell.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 19/06/24.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var title: String = "Product 1"
    var imageName: String = Constants.randomImage
    var imageSize: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotifyLightGray)
                .padding(4)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.spotifyBlack
            .ignoresSafeArea()
        HStack(alignment: .top) {
            ImageTitleRowCell()
            ImageTitleRowCell(title: "Product 23323333")
        }
        
    }
}
