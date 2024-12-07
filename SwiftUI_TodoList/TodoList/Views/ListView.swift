//
//  ListView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 26/10/24.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                EmptyListView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.onToggleCompletion(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.onDeleteItem)
                    .onMove(perform: listViewModel.onMoveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle(Text("Todo List"))
        .navigationBarItems(
            leading: listViewModel.items.isEmpty ? nil : EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}

//struct ListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ListView()
//        }
//    }
//}

#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
