import SwiftUI

struct HomeView: View {

    private enum Layout {
        static let spacing: CGFloat = 20
        static let cardHeight: CGFloat = 140
        static let cornerRadius: CGFloat = 20
        static let padding: CGFloat = 20
    }

    @State private var appeared = false

    var body: some View {
        NavigationStack {
            VStack(spacing: Layout.spacing) {
                Spacer()

                NavigationLink {
                    CashbackView()
                } label: {
                    homeCard(
                        title: "Cashback",
                        subtitle: "Descubre ofertas y ahorra",
                        icon: "percent",
                        gradient: [Color(red: 1, green: 0.82, blue: 0.2), Color(red: 1, green: 0.65, blue: 0.1)]
                    )
                }
                .staggered(index: 0, appeared: $appeared)

                NavigationLink {
                    CardsListView()
                } label: {
                    homeCard(
                        title: "Tus tarjetas",
                        subtitle: "Gestiona tus tarjetas bancarias",
                        icon: "creditcard.fill",
                        gradient: [Color(red: 0.6, green: 0.5, blue: 0.9), Color(red: 0.4, green: 0.35, blue: 0.85)]
                    )
                }
                .staggered(index: 1, appeared: $appeared)

                Spacer()
            }
            .padding(.horizontal, Layout.padding)
            .navigationTitle("Demo")
            .onAppear {
                withAnimation {
                    appeared = true
                }
            }
        }
    }

    private func homeCard(title: String, subtitle: String, icon: String, gradient: [Color]) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 60, height: 60)
                .background(
                    Circle()
                        .fill(.white.opacity(0.25))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.white.opacity(0.7))
        }
        .padding(20)
        .frame(height: Layout.cardHeight)
        .background(
            RoundedRectangle(cornerRadius: Layout.cornerRadius)
                .fill(
                    LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        )
    }
}

#Preview {
    HomeView()
}
