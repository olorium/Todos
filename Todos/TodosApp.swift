//
//  TodosApp.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import SwiftUI

@main
struct TodosApp: App {
	@StateObject var launchScreenState = LaunchScreenStateManager()
	
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
			ZStack {
				MainView()
					.environment(\.managedObjectContext, persistenceController.container.viewContext)

				if launchScreenState.state != .finished {
					LaunchScreenView()
				}
			}.environmentObject(launchScreenState)
        }
    }
}
