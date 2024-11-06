//
//  ListViewModel.swift
//  TodoList
//
//  Created by Dinesh Shaw on 02/11/24.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func onDeleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func onMoveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func onAddItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
    }
    
    func onToggleCompletion(item: ItemModel) {
//        if let index = items.firstIndex(where: { existingItem in
//            return existingItem.id == item.id
//        }) {
//
//        }
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
