import SwiftUI

// MARK: - Shimmer Effect

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1

    var duration: Double
    var bounce: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo in
                    LinearGradient(
                        colors: [
                            .clear,
                            Color.white.opacity(0.4),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.6)
                    .offset(x: phase * geo.size.width * 1.6 - geo.size.width * 0.3)
                    .blendMode(.sourceAtop)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onAppear {
                withAnimation(
                    .linear(duration: duration)
                    .repeatForever(autoreverses: bounce)
                ) {
                    phase = 1
                }
            }
    }
}

extension View {
    func shimmer(duration: Double = 1.5, bounce: Bool = false) -> some View {
        modifier(ShimmerModifier(duration: duration, bounce: bounce))
    }
}

// MARK: - Skeleton Placeholder

struct SkeletonView: View {
    var width: CGFloat?
    var height: CGFloat
    var cornerRadius: CGFloat = 12

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.15))
            .frame(width: width, height: height)
            .shimmer()
    }
}

// MARK: - Staggered Appearance Modifier

struct StaggeredAppearance: ViewModifier {
    let index: Int
    @Binding var appeared: Bool
    let baseDelay: Double

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 24)
            .animation(
                .spring(response: 0.5, dampingFraction: 0.8)
                .delay(Double(index) * baseDelay),
                value: appeared
            )
    }
}

extension View {
    func staggered(index: Int, appeared: Binding<Bool>, delay: Double = 0.08) -> some View {
        modifier(StaggeredAppearance(index: index, appeared: appeared, baseDelay: delay))
    }
}

// MARK: - Animated Number

struct AnimatingNumber: Animatable, View {
    var value: Double
    var specifier: String = "%.2f"
    var suffix: String = ""
    var font: Font = .title.bold()
    var color: Color = .primary

    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    var body: some View {
        Text("\(value, specifier: specifier)\(suffix)")
            .font(font)
            .foregroundStyle(color)
            .contentTransition(.numericText(value: value))
    }
}

// MARK: - Toast Modifier

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: Double

    func body(content: Content) -> some View {
        content.overlay(alignment: .bottom) {
            if isShowing {
                HStack(spacing: 12) {
                    Text(message)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white)
                        .lineLimit(2)

                    Spacer()

                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isShowing = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.caption.bold())
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(red: 0.2, green: 0.2, blue: 0.25))
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
    func toast(isShowing: Binding<Bool>, message: String, duration: Double = 5.0) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}

// MARK: - Scroll Offset Preference Key

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Card Flip Modifier

struct CardFlip: ViewModifier {
    var isFaceUp: Bool
    var axis: (x: CGFloat, y: CGFloat, z: CGFloat) = (0, 1, 0)

    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(isFaceUp ? 0 : 180),
                axis: axis,
                perspective: 0.5
            )
    }
}
