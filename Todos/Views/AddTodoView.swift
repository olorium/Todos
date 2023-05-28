//
//  AddTodoView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import SwiftUI

struct AddTodoView: View {
	// MARK: - Properties
	@Environment(\.managedObjectContext) var managedObjectContext
	@Binding var showAddTodoView: Bool
	@State private var name: String = ""
	@State private var priority: String = "Normal"
	@State private var errorShowing = false
	@State private var errorTitle = ""
	@State private var errorMessage = ""
	let priorities = ["Hight", "Normal", "Low"]

	// MARK: - Body
    var body: some View {
		NavigationView {
			VStack {
				Form {
					TextField("Todo", text: $name)

					Picker("Priority", selection: $priority) {
						ForEach(priorities, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)

					Button {
						if !name.isEmpty {
							let todo = Item(context: managedObjectContext)
							todo.name = name
							todo.priority = priority
							do {
								try managedObjectContext.save()
							} catch {
								print("Error saving todo with error: \(error)")
							}
						} else {
							errorShowing = true
							errorTitle = "Invalid Name"
							errorMessage = "Make sure to add something to the Todo title"
						}
						showAddTodoView = false
					} label: {
						Text("Save")
					}

				}

				Spacer()
			}
			.navigationBarTitle("New Todo", displayMode: .inline)
			.navigationBarItems(trailing: Button(action: {
				showAddTodoView = false
			}, label: {
				Image(systemName: "xmark")
			}))
			.alert(isPresented: $errorShowing) {
				Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
			}
		}
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
		AddTodoView(showAddTodoView: .constant(true))
    }
}
