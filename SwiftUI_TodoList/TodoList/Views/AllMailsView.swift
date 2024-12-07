//
//  AllMailsView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 19/11/24.
//

import SwiftUI

struct AllMailsView: View {
    
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    @State private var activeTab: TabModel = .primary
    
    @State private var scrollOffset: CGFloat = 0
    @State private var topInset: CGFloat = 0
    @State private var startTopInset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    CustomeTabBar(activeTab: $activeTab)
                        .frame(height: isSearchActive ? 0 : nil, alignment: .top)
                        .opacity(isSearchActive ? 0 : 1)
                        .padding(.bottom, isSearchActive ? 0 : 10)
                        .background {
                            let progress = min(max((scrollOffset + startTopInset - 110) / 15, 0), 1)
                            
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                            .padding(.top, -topInset)
                            .opacity(progress)
                        }
                        .offset(y: (scrollOffset + topInset) > 0 ? (scrollOffset + topInset) : 0)
                        .zIndex(1000)
                    
                    LazyVStack(alignment: .leading) {
                        Text("Mails")
                            .font(.title)
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(15)
                    .zIndex(0)
                }
                
            }
            .animation(.easeInOut(duration: 0.2), value: isSearchActive)
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentOffset.y
            }, action: { _, newValue in
                scrollOffset = newValue
            })
            .onScrollGeometryChange(for: CGFloat.self, of: {
                $0.contentInsets.top
            }, action: { oldValue, newValue in
                if startTopInset == .zero {
                    startTopInset = newValue
                }
                topInset = newValue
            })
            .navigationTitle("All Inbox")
            .searchable(text: $searchText, isPresented: $isSearchActive, placement: .navigationBarDrawer(displayMode: .automatic))
            .background(.gray.opacity(0.1))
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
        }
    }
}

struct CustomeTabBar: View {
    
    @Binding var activeTab: TabModel

    var body: some View {
        let isAllMailsTab: Bool = activeTab == .allMails
        GeometryReader { _ in
            HStack(spacing: 8) {
                HStack(spacing: isAllMailsTab ? -12 : 8) {
                    ForEach(TabModel.allCases.filter({ $0 != .allMails }), id: \.rawValue) { tab in
                        ResizableTabButton(tab)
                    }
                }
                if isAllMailsTab {
                    ResizableTabButton(.allMails)
                        .transition(.offset(x: 200))
                }
            }
            .padding(.horizontal, 15)
        }
        .frame(height: 50)
    }
    
    @ViewBuilder
    func ResizableTabButton(_ tab: TabModel) -> some View {
        
        @State var isActive: Bool = activeTab == tab
        let isAllMailsTab: Bool = activeTab == .allMails
        
        HStack(spacing: 8) {
            Image(systemName: tab.symbolImage)
                .overlay {
                    Image(systemName: tab.symbolImage)
                        .symbolVariant(.fill)
                        .opacity(isActive ? 1 : 0)
                }
            
            if isActive {
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
        }
        .foregroundStyle(isActive ? isAllMailsTab ? Color("TextColor") : .white : .gray)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: isActive ?.infinity : nil)
        .padding(.horizontal, 16)
        .background {
            Rectangle()
                .fill(isActive ? tab.color : Color(.systemGray4))
        }
        .cornerRadius(20)
        .background {
            RoundedRectangle(cornerRadius: 23, style: .continuous)
                .fill(.background)
                .padding(isAllMailsTab && tab != .allMails ? -3 : 3)
        }
        
        .onTapGesture {
            guard tab != .allMails else { return }
            withAnimation(.bouncy) {
                activeTab = isActive ? .allMails : tab
            }
        }
    }
}

#Preview {
    AllMailsView()
}
