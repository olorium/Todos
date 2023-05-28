//
//  LaunchScreenView.swift
//  Todos
//
//  Created by Oleksii Vasyliev on 28.05.2023.
//

import SwiftUI

struct LaunchScreenView: View {
	// MARK: - Properties
	/// Source of truth of the animation state.
	@EnvironmentObject private var launchScreenState: LaunchScreenStateManager
	/// Control for the first animation
	@State private var firstAnimation = false
	/// Control for the second animation
	@State private var secondAnimation = false
	/// Control for the fadeout animation
	@State private var startFadeoutAnimation = false

	/// Image view for the launch screen.
	@ViewBuilder
	private var image: some View {
		Image("todo-app-logo")
			.resizable()
			.scaledToFit()
			.frame(width: 100, height: 100)
			.rotationEffect(firstAnimation ? Angle(degrees: 900) : Angle(degrees: 1800))
			.scaleEffect(secondAnimation ? 0 : 1)
			.offset(y: secondAnimation ? 400 : 1)
	}

	/// Timer to trigger animation.
	private let animationTimer = Timer
		.publish(every: 0.5, on: .current, in: .common)
		.autoconnect()

	// MARK: - Body
    var body: some View {
		ZStack {
			image
		}.onReceive(animationTimer) { _ in
			updateAnimation()
		}.opacity(startFadeoutAnimation ? 0 : 1)
    }

	// MARK: - Methods
	/// Updates animation based on state.
	private func updateAnimation() {
		switch launchScreenState.state {
		case .firstStep:
			withAnimation(.easeOut(duration: 0.9)) {
				firstAnimation.toggle()
			}
		case .secondStep:
			if secondAnimation == false {
				withAnimation(.linear) {
					self.secondAnimation = true
					startFadeoutAnimation = true
				}
			}
		case .finished:
			break
		}
	}
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
			.environmentObject(LaunchScreenStateManager())
    }
}
