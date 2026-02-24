import SwiftUI

struct PromoBannerModifier: ViewModifier {
    @Binding var isShowing: Bool
    let title: String
    let subtitle: String
    let icon: String
    let duration: Double

    func body(content: Content) -> some View {
        content.overlay(alignment: .bottom) {
            if isShowing {
                HStack(spacing: 14) {
                    // Icon circle
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.2, green: 0.4, blue: 0.9))
                            .frame(width: 40, height: 40)

                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                    }

                    // Text
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.white)
                            .lineLimit(1)

                        Text(subtitle)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))
                            .lineLimit(1)
                    }

                    Spacer()

                    // Dismiss
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isShowing = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.caption.bold())
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.85, green: 0.3, blue: 0.55),
                                    Color(red: 0.55, green: 0.3, blue: 0.85)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onChange(of: isShowing) { _, newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        isShowing = false
                    }
                }
            }
        }
    }
}

extension View {
    func promoBanner(
        isShowing: Binding<Bool>,
        title: String,
        subtitle: String,
        icon: String = "creditcard.fill",
        duration: Double = 6.0
    ) -> some View {
        modifier(PromoBannerModifier(
            isShowing: isShowing,
            title: title,
            subtitle: subtitle,
            icon: icon,
            duration: duration
        ))
    }
}
