//
//  AppStarter.swift
//  TodoList
//
//  Created by Dinesh Shaw on 01/12/24.
//

import SwiftUI

struct AppStarter: View {
    @AppStorage("showWelcomeScreen") var showWelcomeScreen = true
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                showWelcomeScreen = true
            }
            .sheet(isPresented: $showWelcomeScreen) {
                Text("Hello")
            }
            .interactiveDismissDisabled()
    }
}

#Preview {
    AppStarter()
}
