//
//  ThemeSettings.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 03.06.2023.
//

import SwiftUI

final public class ThemeSettings: ObservableObject {
	@Published public var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
		didSet {
			UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
		}
	}

	private init() {}
	public static let shared = ThemeSettings()
}
