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
	@ObservedObject var theme = ThemeSettings.shared
	@State private var showingAddTodoView = false
	@State private var showingSettingsView = false
	@State private var animatingAddButton = false
	let themes = ThemeData.themes

    // MARK: - Body
    var body: some View {
		NavigationView {
			ZStack {
				if items.count == 0 {
					EmptyListView(themeColor: themes[self.theme.themeSettings].themeColor)
				}
				List {
					ForEach(items, id: \.self) { item in
						HStack {
							Circle()
								.frame(width: 12, height: 12, alignment: .center)
								.foregroundColor(colorize(priority: item.priority ?? "Normal"))
							Text(item.name ?? "")
								.fontWeight(.semibold)
							Spacer()
							Text(item.priority ?? "")
								.font(.footnote)
								.foregroundColor(.gray)
								.padding(3)
								.frame(minWidth: 62)
								.overlay(
									Capsule().stroke(Color.gray, lineWidth: 0.75)
								)
						}
						.padding(.vertical, 10)
					}
					.onDelete(perform: deleteItems)
				}
				.navigationBarTitle("Todo", displayMode: .inline)
				.navigationBarItems(
					leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor),
					trailing:
						Button(action: {
							showingSettingsView = true
						}, label: {
							Image(systemName: "gearshape")
						})
						.accentColor(themes[self.theme.themeSettings].themeColor)
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
				AddTodoButton(showingAddTodoView: $showingAddTodoView, themeColor: themes[self.theme.themeSettings].themeColor), alignment: .bottomTrailing
			)
		}
		.navigationViewStyle(.stack)
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

	/// Updates todo items priority color.
	/// - Parameter priority: priority of the todo item
	/// - Returns: color based on priority
	private func colorize(priority: String) -> Color {
		switch priority {
		case "Hight":
			return .pink
		case "Medium":
			return .green
		case "Low":
			return .blue
		default:
			return .gray
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
