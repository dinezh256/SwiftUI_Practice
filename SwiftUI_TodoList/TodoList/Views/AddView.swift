//
//  AddView.swift
//  TodoList
//
//  Created by Dinesh Shaw on 26/10/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var text: String = ""
    @State var isAlertPresented: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField(text: $text) {
                    Text("Type something here...")
                        .font(.title3)
                }
                .padding()
                .frame(height: 55)
                .background(Color(uiColor: UIColor.secondarySystemBackground))
                .cornerRadius(10)
                
                Button(action: onSaveButtonPressed,
                    label: {
                    Text("Save")
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
        }
        .padding(.horizontal)
        .navigationTitle(Text("Add Item"))
        .alert(isPresented: $isAlertPresented, content: getAlert)
    }
    
    func onSaveButtonPressed() {
        if isTextValid() {
            listViewModel.onAddItem(title: text)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func isTextValid() -> Bool {
        if text.count < 3 || text.trimmingCharacters(in: .whitespaces).isEmpty {
            isAlertPresented.toggle()
            alertMessage = "Title must be at least 3 characters long and should not contain just white spaces!"
            return false
        }
        
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertMessage))
    }
}

#Preview {
    NavigationView {
        AddView()
    }
    .environmentObject(ListViewModel())
}
