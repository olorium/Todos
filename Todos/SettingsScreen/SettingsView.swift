//
//  SettingsView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 29.05.2023.
//

import SwiftUI

struct SettingsView: View {
	// MARK: - Properties
	@ObservedObject var theme = ThemeSettings.shared
	@Binding var showSettingsView: Bool
	let themes = ThemeData.themes

	// MARK: - Body
    var body: some View {
		NavigationView {
			VStack(alignment: .center, spacing: 0) {
				Form {
					Section(header:
						HStack {
							Text("Choose the app theme")
						Image(systemName: "circle.fill")
							.resizable()
							.frame(width: 15, height: 15)
							.foregroundColor(themes[self.theme.themeSettings].themeColor)
						}
					) {
						List {
							ForEach(themes) { theme in
								Button {
									self.theme.themeSettings = theme.id
								} label: {
									HStack {
										Image(systemName: "circle.fill")
											.foregroundColor(theme.themeColor)
										Text(theme.themeName)
									}
								}
								.accentColor(.primary)
							}
						}
					}.padding(.vertical, 3)

					Section(header: Text("Follow us")) {
						FormRowLinkView(icon: "globe", color: .green, title: "Website", link: "https://apple.com")
						FormRowLinkView(icon: "link", color: .blue, title: "Twitter", link: "https://apple.com")
						FormRowLinkView(icon: "play.rectangle", color: .pink, title: "YouTube", link: "https://apple.com")
					}
					.padding(.vertical, 3)

					Section(header: Text("About the application")) {
						FormRowStaticView(icon: "gear", title: "Application", description: "Todo")
						FormRowStaticView(icon: "checkmark.seal", title: "Compatibility", description: "iPhone, iPad")
						FormRowStaticView(icon: "keyboard", title: "Developer", description: "Oleksii Vasyliev")
						FormRowStaticView(icon: "paintbrush", title: "Designer", description: "Robert Petras")
						FormRowStaticView(icon: "flag", title: "Version", description: "1.0.0")
					}
					.padding(.vertical, 3)
				}
				.listStyle(.grouped)
				.environment(\.horizontalSizeClass, .regular)

				Text("Copyright © All rights reserved.\n Developed with ♡ in Berlin.")
					.multilineTextAlignment(.center)
					.font(.footnote)
					.padding(.top, 6)
					.padding(.bottom, 8)
					.foregroundColor(Color.secondary)
			}
			.navigationBarItems(trailing:
				Button(action: {
					showSettingsView = false
				}, label: {
					Image(systemName: "xmark")
				})
			)
			.navigationTitle(Text("Settings"))
			.navigationBarTitleDisplayMode(.inline)
			.background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
		}
		.accentColor(themes[self.theme.themeSettings].themeColor)
		.navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsView(showSettingsView: .constant(false))
    }
}
