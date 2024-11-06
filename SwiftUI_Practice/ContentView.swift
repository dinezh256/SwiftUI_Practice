//
//  ContentView.swift
//  SwiftUI_Practice
//
//  Created by Dinesh Shaw on 07/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Users")
                    .padding()
                ForEach(users) { user in
                    Text(user.firstName)
                        .foregroundStyle(.spotifyGreen)
                }
                
                Text("Products")
                    .padding()
                ForEach(products) { product in
                    Text(product.title)
                }
            }
            
        }
        .frame(width: .infinity)
        .padding(.vertical, 20)
        .task {
            await getData()
        }
    }
    private func getData() async {
        do {
            users = try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
