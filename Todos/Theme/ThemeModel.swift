//
//  ThemeModel.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 03.06.2023.
//

import SwiftUI

struct Theme: Identifiable {
	/// Id of the theme.
	let id: Int
	/// Name of the theme.
	let themeName: String
	/// Theme color.
	let themeColor: Color
}
