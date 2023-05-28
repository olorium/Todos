//
//  TodosApp.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import SwiftUI

@main
struct TodosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
			MainView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
