import SwiftUI

struct CardsListView: View {

    private enum Layout {
        static let hPadding: CGFloat = 16
        static let cardSpacing: CGFloat = 24
        static let buttonHeight: CGFloat = 40
        static let buttonCorner: CGFloat = 20
        static let loadDelay: Double = 0.8
    }

    @State private var isLoading = true
    @State private var appeared = false
    @State private var selectedCard: BankCard?
    @State private var showPromoBanner = false

    private let cards: [BankCard] = [.debitCard, .creditCard]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Layout.cardSpacing) {
                if isLoading {
                    ForEach(0..<2, id: \.self) { _ in
                        SkeletonView(height: 200)
                            .padding(.horizontal, Layout.hPadding)
                    }
                } else {
                    ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                        cardItem(card, index: index)
                    }

                    // Add card button
                    addCardButton
                        .staggered(index: cards.count, appeared: $appeared)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
        .navigationTitle("Tus tarjetas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !isLoading {
                    Button {
                        // Add card action
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "creditcard")
                                .font(.caption)
                            Text("Añadir nueva tarjeta")
                                .font(.caption.weight(.medium))
                        }
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .stroke(Color.primary, lineWidth: 1.5)
                        )
                    }
                }
            }
        }
        .navigationDestination(item: $selectedCard) { card in
            CardDetailView(card: card)
        }
        .promoBanner(
            isShowing: $showPromoBanner,
            title: "Nueva Visa Travel disponible",
            subtitle: "Solicítala ahora y viaja tranquilo"
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Layout.loadDelay) {
                withAnimation(.easeOut(duration: 0.3)) {
                    isLoading = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        appeared = true
                    }
                }
                // Show promo banner ~1.5s after content appears (~2.4s total)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        showPromoBanner = true
                    }
                }
            }
        }
    }

    private func cardItem(_ card: BankCard, index: Int) -> some View {
        Button {
            selectedCard = card
        } label: {
            VStack(spacing: 12) {
                CreditCardView(
                    card: card,
                    gradient: card.gradient,
                    showRefreshButton: false
                )

                // Card info row
                HStack(spacing: 8) {
                    Text(card.type.rawValue)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("**** \(card.lastFour)")
                        .font(.subheadline.bold())
                        .foregroundStyle(.primary)
                }

                // Action buttons
                HStack(spacing: 10) {
                    actionChip(icon: "lock", title: "Bloquear")
                    actionChip(icon: "eye", title: "Ver PIN")
                }
            }
            .padding(.horizontal, Layout.hPadding)
        }
        .buttonStyle(.plain)
        .staggered(index: index, appeared: $appeared, delay: 0.15)
    }

    private func actionChip(icon: String, title: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption2)
            Text(title)
                .font(.caption.weight(.medium))
        }
        .foregroundStyle(.primary)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            Capsule()
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }

    private var addCardButton: some View {
        VStack(spacing: 8) {
            Button { } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.body.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 1.5, dash: [8, 6]))
                )
            }
            .padding(.horizontal, Layout.hPadding)

            Text("Añade una tarjeta")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - BankCard Hashable for navigation

extension BankCard: Hashable {
    static func == (lhs: BankCard, rhs: BankCard) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#Preview {
    NavigationStack {
        CardsListView()
    }
}
