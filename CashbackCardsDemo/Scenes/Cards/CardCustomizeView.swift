import SwiftUI

struct CardCustomizeView: View {

    private enum Layout {
        static let hPadding: CGFloat = 24
        static let thumbnailSize: CGFloat = 52
        static let cardPadding: CGFloat = 32
        static let buttonHeight: CGFloat = 56
        static let buttonCorner: CGFloat = 16
        static let rotationDuration: Double = 0.7
    }

    let card: BankCard
    @Binding var currentGradient: CardGradient

    @Environment(\.dismiss) private var dismiss
    @State private var appeared = false
    @State private var selectedDesign: CardDesign
    @State private var rotationDegrees: Double = 0
    @State private var cardOffset: CGFloat = 0
    @State private var previousDesignIndex: Int = 0
    @State private var showingBackInTransition = false

    init(card: BankCard, currentGradient: Binding<CardGradient>) {
        self.card = card
        self._currentGradient = currentGradient
        // Find the matching design or default to first
        let matchingDesign = CardDesign.designs.first { $0.gradient == currentGradient.wrappedValue }
            ?? CardDesign.designs[0]
        self._selectedDesign = State(initialValue: matchingDesign)
        self._previousDesignIndex = State(initialValue: CardDesign.designs.firstIndex(of: matchingDesign) ?? 0)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            header

            Spacer()

            // Title
            VStack(alignment: .leading, spacing: 8) {
                Text("Selecciona tu")
                    .font(.largeTitle.bold())
                Text("opción favorita")
                    .font(.largeTitle.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Layout.hPadding)
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 20)
            .animation(.easeOut(duration: 0.4).delay(0.1), value: appeared)

            Spacer()

            // Card preview with 3D rotation
            cardPreview
                .padding(.horizontal, Layout.cardPadding)

            Spacer()

            // Design selector thumbnails
            designSelector
                .padding(.bottom, 20)

            // Confirm button
            confirmButton
                .padding(.horizontal, Layout.hPadding)
                .padding(.bottom, 16)
        }
        .background(Color(.systemBackground))
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                appeared = true
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.primary)
            }

            Text("Personalizar")
                .font(.headline)

            Spacer()
        }
        .padding(.horizontal, Layout.hPadding)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    // MARK: - Card Preview

    private var cardPreview: some View {
        ZStack {
            // Shadow card behind (next design peek)
            let nextIndex = (CardDesign.designs.firstIndex(of: selectedDesign) ?? 0 + 1) % CardDesign.designs.count
            CreditCardView(
                card: card,
                gradient: CardDesign.designs[nextIndex].gradient,
                showRefreshButton: false
            )
            .scaleEffect(0.92)
            .offset(x: 20)
            .opacity(0.4)

            // Main card with flash back
            ZStack {
                if showingBackInTransition {
                    CardBackView(card: card, gradient: selectedDesign.gradient)
                        .scaleEffect(x: -1, y: 1)
                } else {
                    CreditCardView(
                        card: card,
                        gradient: selectedDesign.gradient,
                        showRefreshButton: false
                    )
                }
            }
            .rotation3DEffect(
                .degrees(rotationDegrees),
                axis: (x: 0.1, y: 1, z: 0.05),
                perspective: 0.4
            )
            .offset(x: cardOffset)
        }
        .opacity(appeared ? 1 : 0)
        .scaleEffect(appeared ? 1 : 0.8)
        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: appeared)
    }

    // MARK: - Design Selector

    private var designSelector: some View {
        HStack(spacing: 16) {
            ForEach(CardDesign.designs) { design in
                Button {
                    selectDesign(design)
                } label: {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: design.thumbnailColors,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: Layout.thumbnailSize, height: Layout.thumbnailSize)

                        if selectedDesign == design {
                            Circle()
                                .stroke(.primary, lineWidth: 2.5)
                                .frame(width: Layout.thumbnailSize + 6, height: Layout.thumbnailSize + 6)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 30)
        .animation(.easeOut(duration: 0.4).delay(0.35), value: appeared)
    }

    // MARK: - Confirm Button

    private var confirmButton: some View {
        Button {
            currentGradient = selectedDesign.gradient
            dismiss()
        } label: {
            Text("Confirmar")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: Layout.buttonHeight)
                .background(
                    RoundedRectangle(cornerRadius: Layout.buttonCorner)
                        .fill(Color(red: 0.15, green: 0.15, blue: 0.17))
                )
        }
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 20)
        .animation(.easeOut(duration: 0.4).delay(0.45), value: appeared)
    }

    // MARK: - Design Selection Animation

    private func selectDesign(_ design: CardDesign) {
        guard design != selectedDesign else { return }

        let currentIndex = CardDesign.designs.firstIndex(of: selectedDesign) ?? 0
        let newIndex = CardDesign.designs.firstIndex(of: design) ?? 0
        let direction: Double = newIndex > currentIndex ? 1 : -1

        // Phase 1: Rotate out (A18: 90° and 60px)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            rotationDegrees = direction * 90
            cardOffset = -direction * 60
        }

        // A19: Flash the back at ~0.15s
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            showingBackInTransition = true
        }

        // Phase 2: Switch design and rotate in (A18: delay 0.25s)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            selectedDesign = design
            showingBackInTransition = false
            rotationDegrees = -direction * 90
            cardOffset = direction * 60

            withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                rotationDegrees = 0
                cardOffset = 0
            }
        }

        previousDesignIndex = newIndex
    }
}

#Preview {
    CardCustomizeView(
        card: .debitCard,
        currentGradient: .constant(BankCard.debitCard.gradient)
    )
}
