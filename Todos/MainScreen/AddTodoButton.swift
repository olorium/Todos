//
//  AddTodoButton.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 29.05.2023.
//

import SwiftUI

/// View with animated add todo item button
struct AddTodoButton: View {
	/// `true` if button is animating. Default is `false`
	@State private var animatingAddButton = false
	/// Binding to define `AddTodoView` is showing
	@Binding var showingAddTodoView: Bool

	var body: some View {
		ZStack {
			Group {
				Circle()
					.fill(Color.blue)
					.opacity(animatingAddButton ? 0.2 : 0)
					.scaleEffect(animatingAddButton ? 1 : 0)
					.frame(width: 68, height: 68, alignment: .center)
				Circle()
					.fill(Color.blue)
					.opacity(animatingAddButton ? 0.15 : 0)
					.scaleEffect(animatingAddButton ? 1 : 0)
					.frame(width: 88, height: 88, alignment: .center)
			}
			.animation(.easeOut(duration: 2).repeatForever(autoreverses: true))

			Button(action: {
				showingAddTodoView = true
			}, label: {
				Image(systemName: "plus.circle.fill")
					.resizable()
					.scaledToFit()
					.background(Circle().fill(Color("ColorBase")))
					.frame(width: 48, height: 48, alignment: .center)
			})
			.onAppear { animatingAddButton.toggle() }
		}
		.padding(.bottom, 15)
		.padding(.trailing, 15)

	}
}

struct AddTodoButton_Previews: PreviewProvider {
	static var previews: some View {
		AddTodoButton(showingAddTodoView: .constant(false))
	}
}
