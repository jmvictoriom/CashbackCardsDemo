import SwiftUI

struct CardDetailView: View {

    private enum Layout {
        static let hPadding: CGFloat = 16
        static let cardTopPadding: CGFloat = 8
        static let cornerRadius: CGFloat = 24
        static let sheetMinHeight: CGFloat = 300
        static let flipDuration: Double = 0.6
    }

    let card: BankCard

    @State private var appeared = false
    @State private var showingBack = false
    @State private var flipDegrees: Double = 0
    @State private var showCustomize = false
    @State private var currentGradient: CardGradient
    @State private var scrollOffset: CGFloat = 0
    @State private var cardScale: CGFloat = 1.0

    init(card: BankCard) {
        self.card = card
        _currentGradient = State(initialValue: card.gradient)
    }

    var body: some View {
        GeometryReader { outerGeo in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // White top section with card
                    cardSection(outerGeo: outerGeo)

                    // Dark bottom section with movements
                    movementsSection
                }
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(
                            key: ScrollOffsetKey.self,
                            value: geo.frame(in: .named("scroll")).minY
                        )
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                withAnimation(.interactiveSpring) {
                    let offset = -value
                    scrollOffset = offset
                    cardScale = max(0.7, 1.0 - offset / 600)
                }
            }
        }
        .navigationTitle("Tus tarjetas")
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showCustomize) {
            CardCustomizeView(
                card: card,
                currentGradient: $currentGradient
            )
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                appeared = true
            }
        }
    }

    // MARK: - Card Section

    private func cardSection(outerGeo: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            // Personalizar button
            Button {
                showCustomize = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "gearshape")
                        .font(.caption)
                    Text("Personalizar")
                        .font(.caption.weight(.medium))
                }
                .foregroundStyle(.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .stroke(Color.primary, lineWidth: 1.5)
                )
            }
            .staggered(index: 0, appeared: $appeared)

            // Animated card with flip
            ZStack {
                if showingBack {
                    CardBackView(card: card, gradient: currentGradient)
                        .scaleEffect(x: -1, y: 1)
                } else {
                    CreditCardView(
                        card: card,
                        gradient: currentGradient,
                        showRefreshButton: true,
                        onRefresh: {
                            flipCard()
                        }
                    )
                }
            }
            .scaleEffect(cardScale)
            .rotation3DEffect(
                .degrees(flipDegrees),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .padding(.horizontal, Layout.hPadding)
            .staggered(index: 1, appeared: $appeared)

            // Card details row
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(card.type.rawValue)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 4) {
                        Text("**** \(card.lastFour)")
                            .font(.subheadline.bold())

                        Button { } label: {
                            Image(systemName: "doc.on.doc")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Gastado este mes")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    AnimatingNumber(
                        value: appeared ? card.spentThisMonth : 0,
                        specifier: "%.2f",
                        suffix: "€",
                        font: .subheadline.bold()
                    )
                }
            }
            .padding(.horizontal, Layout.hPadding)
            .staggered(index: 2, appeared: $appeared)

            // Action buttons
            HStack(spacing: 10) {
                actionChip(icon: "lock", title: "Bloquear")
                actionChip(icon: "eye", title: "Ver PIN")
            }
            .staggered(index: 3, appeared: $appeared)

            Spacer().frame(height: 20)
        }
        .padding(.top, Layout.cardTopPadding)
    }

    // MARK: - Movements Section

    private var movementsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Text("Últimos movimientos")
                    .font(.title3.bold())
                    .foregroundStyle(.white)

                Spacer()

                Menu {
                    Button("Todos") { }
                    Button("Ingresos") { }
                    Button("Gastos") { }
                } label: {
                    HStack(spacing: 4) {
                        Text("Filtrar")
                            .font(.subheadline.weight(.medium))
                        Image(systemName: "chevron.down")
                            .font(.caption2.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(.white.opacity(0.15))
                    )
                }
            }
            .padding(.horizontal, Layout.hPadding)
            .padding(.top, 24)
            .padding(.bottom, 8)

            // Transaction list
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(Array(Transaction.sampleTransactions.enumerated()), id: \.offset) { sectionIndex, section in
                    TransactionSectionView(
                        date: section.0,
                        transactions: section.1
                    )
                    .padding(.horizontal, Layout.hPadding)
                    .staggered(index: 4 + sectionIndex, appeared: $appeared, delay: 0.1)
                }
            }
            .padding(.bottom, 40)
        }
        .background(
            RoundedRectangle(cornerRadius: Layout.cornerRadius)
                .fill(Color(red: 0.1, green: 0.1, blue: 0.12))
                .ignoresSafeArea(.all, edges: .bottom)
        )
    }

    // MARK: - Helpers

    private func flipCard() {
        let target = showingBack ? 0.0 : 180.0
        withAnimation(.spring(response: Layout.flipDuration, dampingFraction: 0.8)) {
            flipDegrees = target
        }
        // Swap content at ~35% of the flip (when card is edge-on at 90°)
        DispatchQueue.main.asyncAfter(deadline: .now() + Layout.flipDuration * 0.35) {
            showingBack.toggle()
        }
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
}

#Preview {
    NavigationStack {
        CardDetailView(card: .debitCard)
    }
}
