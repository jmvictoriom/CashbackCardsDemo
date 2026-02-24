import SwiftUI

struct CreditCardView: View {

    private enum Layout {
        static let aspectRatio: CGFloat = 1.586 // Standard card ratio
        static let cornerRadius: CGFloat = 16
        static let padding: CGFloat = 20
        static let chipWidth: CGFloat = 36
        static let chipHeight: CGFloat = 28
        static let chipCorner: CGFloat = 6
        static let contactlessSize: CGFloat = 24
        static let refreshSize: CGFloat = 32
        static let networkFontSize: CGFloat = 22
    }

    let card: BankCard
    let gradient: CardGradient
    var showRefreshButton: Bool = true
    var onRefresh: (() -> Void)?

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width / Layout.aspectRatio

            ZStack {
                // Card background
                RoundedRectangle(cornerRadius: Layout.cornerRadius)
                    .fill(
                        LinearGradient(
                            colors: gradient.colors,
                            startPoint: gradient.startPoint,
                            endPoint: gradient.endPoint
                        )
                    )

                // Decorative wave overlay
                cardWaveOverlay(width: width, height: height)

                // Card content
                VStack {
                    HStack {
                        // Contactless icon
                        Image(systemName: "wave.3.right")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                            .rotationEffect(.degrees(90))

                        Spacer()

                        if showRefreshButton {
                            Button {
                                onRefresh?()
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: Layout.refreshSize, height: Layout.refreshSize)
                                    .background(
                                        Circle()
                                            .fill(.black.opacity(0.25))
                                    )
                            }
                        }
                    }

                    Spacer()

                    HStack(alignment: .bottom) {
                        // Chip
                        RoundedRectangle(cornerRadius: Layout.chipCorner)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.75, green: 0.6, blue: 0.4),
                                        Color(red: 0.85, green: 0.7, blue: 0.5)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: Layout.chipWidth, height: Layout.chipHeight)
                            .overlay(
                                RoundedRectangle(cornerRadius: Layout.chipCorner)
                                    .stroke(.white.opacity(0.3), lineWidth: 0.5)
                            )

                        Spacer()

                        // Network logo
                        Text(card.network)
                            .font(.system(size: Layout.networkFontSize, weight: .bold))
                            .foregroundStyle(.white)
                            .italic()
                    }
                }
                .padding(Layout.padding)
            }
            .frame(width: width, height: height)
        }
        .aspectRatio(Layout.aspectRatio, contentMode: .fit)
    }

    private func cardWaveOverlay(width: CGFloat, height: CGFloat) -> some View {
        Canvas { context, size in
            let path = Path { p in
                p.move(to: CGPoint(x: 0, y: size.height * 0.4))
                p.addCurve(
                    to: CGPoint(x: size.width, y: size.height * 0.6),
                    control1: CGPoint(x: size.width * 0.3, y: size.height * 0.2),
                    control2: CGPoint(x: size.width * 0.7, y: size.height * 0.8)
                )
                p.addLine(to: CGPoint(x: size.width, y: size.height))
                p.addLine(to: CGPoint(x: 0, y: size.height))
                p.closeSubpath()
            }
            context.fill(path, with: .color(.white.opacity(0.08)))

            let path2 = Path { p in
                p.move(to: CGPoint(x: 0, y: size.height * 0.55))
                p.addCurve(
                    to: CGPoint(x: size.width, y: size.height * 0.45),
                    control1: CGPoint(x: size.width * 0.4, y: size.height * 0.7),
                    control2: CGPoint(x: size.width * 0.6, y: size.height * 0.3)
                )
                p.addLine(to: CGPoint(x: size.width, y: size.height))
                p.addLine(to: CGPoint(x: 0, y: size.height))
                p.closeSubpath()
            }
            context.fill(path2, with: .color(.white.opacity(0.05)))
        }
        .clipShape(RoundedRectangle(cornerRadius: Layout.cornerRadius))
    }
}

#Preview {
    CreditCardView(
        card: .debitCard,
        gradient: BankCard.debitCard.gradient
    )
    .padding(20)
}
