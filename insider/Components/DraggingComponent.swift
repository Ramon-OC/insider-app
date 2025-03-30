//
//  DraggingComponent.swift
//  insider
//
//  Created by José Ramón Ortiz Castañeda on 27/03/25.
//

import SwiftUI
import CoreHaptics

public struct SliderBackground: View {
    public var body: some View {
        ZStack(alignment: .leading)  {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.insiderRed.opacity(0.6), Color.insiderRed.opacity(0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            Text(NSLocalizedString("slide-message", comment: "slide to unlock"))
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
        }
    }
}

public struct DraggingComponent: View {
    @State private var width = CGFloat(50)
    @Binding var isLocked: Bool
    let maxWidth: CGFloat

    private  let minWidth = CGFloat(50)

    public init(isLocked: Binding<Bool>, maxWidth: CGFloat) {
        _isLocked = isLocked
        self.maxWidth = maxWidth
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.insiderRed)
            .opacity(width / maxWidth)
            .frame(width: width)
            .overlay(
                Button(action: { }) {
                    ZStack {
                        image(name: "lock", isShown: isLocked)
                        image(name: "lock.open", isShown: !isLocked)
                    }
                    .animation(.easeIn(duration: 0.35).delay(0.55), value: !isLocked)
                }
                .buttonStyle(BaseButtonStyle())
                .disabled(!isLocked),
                alignment: .trailing
            )

            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                        guard isLocked else { return }
                    if value.translation.width > 0 {
                        width = min(max(value.translation.width + minWidth, minWidth), maxWidth)
                    }
                        
                    }
                    .onEnded { value in
                        guard isLocked else { return }
                        if width < maxWidth {
                            width = minWidth
                            UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        } else {
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            withAnimation(.spring().delay(0.5)) {
                                isLocked = false
                            }
                        }
                    }
            )
            .animation(.spring(response: 0.5, dampingFraction: 1, blendDuration: 0), value: width)

    }

    private func image(name: String, isShown: Bool) -> some View {
        Image(systemName: name)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(Color.insiderRed)
            .frame(width: 42, height: 42)
            .background(RoundedRectangle(cornerRadius: 14).fill(.white))
            .padding(4)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }

    private func progressView(isShown: Bool) -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
            .opacity(isShown ? 1 : 0)
            .scaleEffect(isShown ? 1 : 0.01)
    }
}

public struct BaseButtonStyle: ButtonStyle {
    public init() { }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.default, value: configuration.isPressed)
    }
}
