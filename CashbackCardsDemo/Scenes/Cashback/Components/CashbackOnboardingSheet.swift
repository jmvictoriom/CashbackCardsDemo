import SwiftUI

struct CashbackOnboardingSheet: View {

    @Environment(\.dismiss) private var dismiss
    @State private var appeared = false

    private let brands: [Brand] = [.europcar, .vicio, .northFace]
    private let fanAngles: [Double] = [-12, 0, 12]

    var body: some View {
        ZStack(alignment: .top) {
            // Opaque white background with rounded top corners
            UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                .fill(Color.white)
                .padding(.top, 80)

            // Content
            VStack(spacing: 0) {
                // Fan of brand cards – sticks out above the white area
                ZStack {
                    ForEach(Array(brands.enumerated()), id: \.element.id) { index, brand in
                        brandMiniCard(brand)
                            .rotationEffect(
                                .degrees(appeared ? fanAngles[index] : 0),
                                anchor: .bottom
                            )
                            .offset(y: appeared ? 0 : 40)
                            .opacity(appeared ? 1 : 0)
                            .animation(
                                .spring(response: 0.6, dampingFraction: 0.7)
                                .delay(0.2 + Double(index) * 0.1),
                                value: appeared
                            )
                    }
                }
                .frame(height: 160)
                .padding(.bottom, 16)

                // Title
                Text("Cashback")
                    .font(.largeTitle.bold())
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(0.5), value: appeared)

                // Subtitle
                Text("Compra más y gasta menos: te devolvemos dinero en cada compra")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.top, 4)
                    .padding(.horizontal, 24)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(.easeOut(duration: 0.4).delay(0.6), value: appeared)

                // Bullet points
                VStack(alignment: .leading, spacing: 16) {
                    bulletPoint(icon: "globe.europe.africa", text: "Ofertas de ocio, moda y viajes")
                    bulletPoint(icon: "creditcard", text: "Paga con tu tarjeta CaixaBank")
                    bulletPoint(icon: "eurosign.circle", text: "Recibe tu cashback en tu cuenta")
                }
                .padding(.top, 32)
                .padding(.horizontal, 24)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
                .animation(.easeOut(duration: 0.4).delay(0.7), value: appeared)

                Spacer()

                // Continue button
                Button {
                    dismiss()
                } label: {
                    Text("Continuar")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.17))
                        )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
                .animation(.easeOut(duration: 0.4).delay(0.8), value: appeared)
            }
        }
        .onAppear {
            withAnimation {
                appeared = true
            }
        }
    }

    private func brandMiniCard(_ brand: Brand) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(brand.logoColor)
                    .frame(width: 44, height: 44)

                Text(brand.logoLetter)
                    .font(.system(size: brand.logoLetter.count > 2 ? 10 : 16, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text("\(brand.cashbackPercent)%")
                .font(.caption.bold())
                .foregroundStyle(.primary)
        }
        .frame(width: 90, height: 110)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
        )
    }

    private func bulletPoint(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.25))
                .frame(width: 24)

            Text(text)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
    }
}

#Preview {
    CashbackOnboardingSheet()
}
