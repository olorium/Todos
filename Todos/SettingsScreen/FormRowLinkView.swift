//
//  FormRowLinkView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 29.05.2023.
//

import SwiftUI

struct FormRowLinkView: View {
	// MARK: - Properties

	/// Icon for the row
	var icon: String
	/// Color for the row
	var color: Color
	/// Title for the row
	var title: String
	/// Weblink for the row
	var link: String

	// MARK: - Body
    var body: some View {
		HStack {
			ZStack {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(color)
				Image(systemName: icon)
					.imageScale(.large)
					.foregroundColor(.white)
			}
			.frame(width: 36, height: 36, alignment: .center)

			Text(title)
				.foregroundColor(.gray)

			Spacer()

			Button {
				guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else { return }
				UIApplication.shared.open(url as URL)
			} label: {
				Image(systemName: "chevron.right")
					.font(.system(size: 14, weight: .semibold, design: .rounded))
					.accentColor(Color(.systemGray2))
			}

		}
    }
}

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
		FormRowLinkView(icon: "globe", color: .pink, title: "Website", link: "https://apple.com")
			.previewLayout(.fixed(width: 375, height: 60))
			.padding()
    }
}
