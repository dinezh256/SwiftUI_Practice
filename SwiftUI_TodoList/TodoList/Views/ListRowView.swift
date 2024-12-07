//
//  ListRowView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 26/10/24.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel

    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
            Text(item.title)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
        }
        .font(.title3)
        .padding(.vertical, 4)
    }
}

#Preview {

    Group {
        ListRowView(item: ItemModel(title: "Hello", isCompleted: true))
        ListRowView(item: ItemModel(title: "Hello", isCompleted: false))
    }
}
