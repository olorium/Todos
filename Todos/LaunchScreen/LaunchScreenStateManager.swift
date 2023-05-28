//
//  LaunchScreenStateManager.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import Foundation

/// State manager for launch screen.
final class LaunchScreenStateManager: ObservableObject {
	/// Current state of launch screen.
	@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

	/// Method called to roll through launch states till finish.
	@MainActor func dismiss() {
		Task {
			state = .secondStep

			try? await Task.sleep(nanoseconds: 1000_000)

			self.state = .finished
		}
	}
}
