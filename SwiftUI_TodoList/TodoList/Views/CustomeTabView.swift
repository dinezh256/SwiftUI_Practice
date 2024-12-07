//
//  CustomeTabView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 29/11/24.
//

import SwiftUI

struct CustomeTabView: View {
    @State private var selectedTab: Int = 1
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Click Me 1")
                .font(.headline)
                .tag(1)

            Text("Click Me 2")
                .font(.headline)
                .tag(2)

            Text("Click Me 3")
                .font(.headline)
                .tag(3)
            Text("Click Me 4")
                .font(.headline)
                .tag(4)
        }
        .overlay(alignment: .bottom) {
            BottomTab(selectedTab: $selectedTab)
        }

    }
}

struct BottomTab: View {
    @Binding var selectedTab: Int
    @Namespace private var dineshNS

    let tabItems: [(image: String, title: String)] = [
        ("house", "Home"),
        ("magnifyingglass", "Search"),
        ("heart", "Favorites"),
        ("person", "Profile"),
    ]

    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 76)
                .foregroundStyle(Color(.secondarySystemBackground))
                .shadow(radius: 2)

            HStack {
                ForEach(Array(tabItems.enumerated()), id: \.offset) {
                    index, tabItem in
                    Button(action: {
                        selectedTab = index + 1
                    }) {
                        let isSelected = selectedTab == index + 1
                        VStack(spacing: 8) {
                            Spacer()
                            Image(systemName: tabItem.image)
                                .imageScale(Image.Scale.large)

                            Text(tabItem.title)
                                .font(.caption)

                            Capsule()
                                .frame(height: 8)
                                .foregroundStyle(
                                    Color(isSelected ? .blue : .clear)
                                )
                                .matchedGeometryEffect(
                                    id: "SelectedTabId", in: dineshNS,
                                    isSource: isSelected
                                )
                                .offset(y: 4)
                        }
                        .foregroundStyle(Color(isSelected ? .blue : .gray))
                    }
                }
            }
            .padding(.horizontal, 32)
        }
        .clipShape(Capsule())
        .padding(.horizontal, 24)
        .frame(height: 76)
        .frame(maxWidth: 400)
    }
}

#Preview {
    CustomeTabView()
}
