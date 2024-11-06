//
//  EmptyListView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 04/11/24.
//

import SwiftUI

struct EmptyListView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are no tasks to show")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("You can add new tasks by tapping the below add button")
                    .padding(20)
                
                NavigationLink(
                    destination: AddView(),
                    label:  {
                        Text("Add New Task")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 55)
                            .background(animate ? Color.purple : Color.accentColor)
                            .shadow(
                                color: (animate ? Color.purple : Color.accentColor).opacity(0.7), radius: 20
                            )
                            .cornerRadius(10)
                    }
                )
                .padding(.horizontal, animate ? 80 : 50)
            }
            .multilineTextAlignment(.center)
            .padding(20)
        }
        .frame(maxWidth: .infinity)
        .onAppear(perform: onAnimate)
    }
    
    func onAnimate() {
        if (animate) { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            withAnimation(.easeInOut(duration: 2.0).repeatForever()) {
                animate.toggle()
            }
            
        })
    }
}

#Preview {
    NavigationView {
        EmptyListView()
            .navigationTitle(Text("Empty List View"))
    }
    
}
