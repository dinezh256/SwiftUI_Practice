//
//  EmptyListView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 04/11/24.
//

import SwiftUI

struct
    EmptyListView: View {
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        ScrollView {
            VStack {
                Text("There are no tasks")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("You can add new tasks by tapping the below button")
                    .padding(20)
                
                NavigationLink(
                    destination: AddView(),
                    label:  {
                        Text("+ New Task")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 55)
                            .background(animate ? secondaryAccentColor : Color.accentColor)
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: (animate ? secondaryAccentColor : Color.accentColor).opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0.0,
                        y: animate ? 50 : 30
                    )
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: onAnimate)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
