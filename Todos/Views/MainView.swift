//
//  MainView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import SwiftUI
import CoreData

struct MainView: View {
	// MARK: - Properties
	@Environment(\.managedObjectContext) var managedObjectContext
	@FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)], animation: .default)
	private var items: FetchedResults<Item>
	@State private var showingAddTodoView = false

    // MARK: - Body
    var body: some View {
		NavigationView {
			List {
				ForEach(items, id: \.self) { item in
					HStack {
						Text(item.name ?? "")
						Spacer()
						Text(item.priority ?? "")
					}
				}
				.onDelete(perform: deleteItems)
			}
			.navigationBarTitle("Todo", displayMode: .inline)
			.navigationBarItems(
				leading: EditButton(),
				trailing:
					Button(action: {
						showingAddTodoView = true
					}, label: {
						Image(systemName: "plus")
					})
					.sheet(isPresented: $showingAddTodoView) { AddTodoView(showAddTodoView: $showingAddTodoView)}
					.environment(\.managedObjectContext, managedObjectContext)
			)
		}
    }

	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(managedObjectContext.delete)

			do {
				try managedObjectContext.save()
			} catch {
				print("Error updating todo with error: \(error)")
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
