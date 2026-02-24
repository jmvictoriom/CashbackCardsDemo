import SwiftUI

struct CardBackView: View {

    private enum Layout {
        static let aspectRatio: CGFloat = 1.586
        static let cornerRadius: CGFloat = 16
        static let padding: CGFloat = 20
        static let stripHeight: CGFloat = 44
    }

    let card: BankCard
    let gradient: CardGradient
    @State private var showCVV = false

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

                // White overlay for back feel
                RoundedRectangle(cornerRadius: Layout.cornerRadius)
                    .fill(.white.opacity(0.12))

                VStack(spacing: 0) {
                    // Magnetic strip
                    Rectangle()
                        .fill(.black.opacity(0.6))
                        .frame(height: Layout.stripHeight)
                        .padding(.top, 20)

                    Spacer()

                    // Card details
                    VStack(alignment: .leading, spacing: 12) {
                        // Full number
                        Text(card.fullNumber)
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(.white)
                            .tracking(2)

                        HStack {
                            // Expiry
                            VStack(alignment: .leading, spacing: 2) {
                                Text("VALID THRU")
                                    .font(.system(size: 8, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.6))
                                Text(card.expiryDate)
                                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                    .foregroundStyle(.white)
                            }

                            Spacer()

                            // CVV with toggle
                            HStack(spacing: 8) {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("CVV")
                                        .font(.system(size: 8, weight: .medium))
                                        .foregroundStyle(.white.opacity(0.6))
                                    Text(showCVV ? card.cvv : "***")
                                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                        .foregroundStyle(.white)
                                }

                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        showCVV.toggle()
                                    }
                                } label: {
                                    Image(systemName: showCVV ? "eye.slash.fill" : "eye.fill")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white.opacity(0.7))
                                }
                            }
                        }

                        // Network
                        HStack {
                            Spacer()
                            Text(card.network)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                                .italic()
                        }
                    }
                    .padding(Layout.padding)
                }
            }
            .frame(width: width, height: height)
        }
        .aspectRatio(Layout.aspectRatio, contentMode: .fit)
    }
}

#Preview {
    CardBackView(
        card: .debitCard,
        gradient: BankCard.debitCard.gradient
    )
    .padding(20)
}
