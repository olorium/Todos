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
	@EnvironmentObject private var launchScreenState: LaunchScreenStateManager
	@Environment(\.managedObjectContext) var managedObjectContext
	@FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)], animation: .default)
	private var items: FetchedResults<Item>
	@State private var showingAddTodoView = false
	@State private var showingSettingsView = false
	@State private var animatingAddButton = false

    // MARK: - Body
    var body: some View {
		NavigationView {
			ZStack {
				if items.count == 0 {
					EmptyListView()
				}
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
							showingSettingsView = true
						}, label: {
							Image(systemName: "gearshape")
						})
						.sheet(isPresented: $showingSettingsView) { SettingsView(showSettingsView: $showingSettingsView) }
						.environment(\.managedObjectContext, managedObjectContext)
				)
				.onAppear {
					Task {
						try? await Task.sleep(nanoseconds: 1000_000)
						self.launchScreenState.dismiss()
					}
				}
			}
			.sheet(isPresented: $showingAddTodoView) { AddTodoView(showAddTodoView: $showingAddTodoView)}
			.overlay(
				AddTodoButton(showingAddTodoView: $showingAddTodoView), alignment: .bottomTrailing
			)
		}
    }

	// MARK: - Methods
	/// Deletes todo item from the list
	/// - Parameter offsets: IndexSet of item to delete, passed automatically.
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
        MainView()
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
			.environmentObject(LaunchScreenStateManager())
    }
}
