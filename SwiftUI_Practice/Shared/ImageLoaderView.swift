//
//  ImageLoaderView.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 07/06/24.
//

import SwiftUI
import MapKit
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    var urlString: String = Constants.randomImage
    var resizingMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay(
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(30)
        .clipShape(Circle())
        .overlay {
            Circle().stroke(.blue, lineWidth: 4)
        }
        .shadow(radius: 7)
        .padding(40)
        .padding(.vertical, 60)
}
