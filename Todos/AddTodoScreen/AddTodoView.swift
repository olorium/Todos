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
	var errorTitle = "Invalid Input"
	var errorMessage = "Make sure to add something to the Todo title"
	let priorities = ["Hight", "Normal", "Low"]

	// MARK: - Body
    var body: some View {
		NavigationView {
			VStack {
				VStack(alignment: .leading, spacing: 20) {
					TextField("Todo", text: $name)
						.padding()
						.background(Color(UIColor.tertiarySystemFill))
						.cornerRadius(9)
						.font(.system(size: 24, weight: .bold, design: .default))

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
							showAddTodoView = false
						} else {
							errorShowing = true
						}
					} label: {
						Text("Save")
							.font(.system(size: 24, weight: .bold, design: .default))
							.padding()
							.frame(minWidth: 0, maxWidth: .infinity)
							.background(Color.blue)
							.cornerRadius(9)
							.foregroundColor(.white)
					}

				}
				.padding(.horizontal)
				.padding(.vertical, 30)

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
