import SwiftUI

struct GlassSurface<Content: View>: View {
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var cornerRadius: CGFloat = 20
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(16)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(reduceTransparency ? 0.24 : 0.35), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
            .animation(reduceMotion ? nil : .easeOut(duration: 0.2), value: reduceTransparency)
    }

    @ViewBuilder
    private var background: some View {
        if reduceTransparency {
            Color(uiColor: .secondarySystemBackground)
        } else {
            .ultraThinMaterial
        }
    }
}
