//
//  FormRowView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 29.05.2023.
//

import SwiftUI

struct FormRowStaticView: View {
	// MARK: - Properties
	/// Icon of the row
	var icon: String
	/// Title for the row
	var title: String
	/// Description for the row
	var description: String

	// MARK: - Body
    var body: some View {
		HStack {
			ZStack {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(Color.gray)
				Image(systemName: icon)
					.foregroundColor(.white)
			}
			.frame(width: 36, height: 36, alignment: .center)

			Text(title)
				.foregroundColor(.gray)

			Spacer()

			Text(description)

		}
    }
}

struct FormRowView_Previews: PreviewProvider {
    static var previews: some View {
		FormRowStaticView(icon: "gear", title: "Application", description: "Todo")
			.previewLayout(.fixed(width: 375, height: 60))
			.padding()
    }
}
