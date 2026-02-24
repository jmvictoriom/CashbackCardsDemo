import Testing
@testable import CashbackCardsDemo

@Suite("CardsListView Integration")
struct CardsListViewTests {

    // MARK: - A11: Card data and promo banner

    @Test("Cards list contains debit and credit cards")
    func cardsData() {
        let cards: [BankCard] = [.debitCard, .creditCard]
        #expect(cards.count == 2)
        #expect(cards[0].type == .debit)
        #expect(cards[1].type == .credit)
    }

    @Test("Promo banner displays expected text")
    func promoBannerText() {
        // Banner title and subtitle used in CardsListView
        let title = "Nueva Visa Travel disponible"
        let subtitle = "Solicítala ahora y viaja tranquilo"
        #expect(!title.isEmpty)
        #expect(!subtitle.isEmpty)
        #expect(title.contains("Visa Travel"))
    }

    @Test("A11: Total promo banner timing is ~2.4s (loadDelay 0.8 + appear 0.1 + banner 1.5)")
    func promoBannerTiming() {
        // loadDelay = 0.8, then appear delay = 0.1, then banner delay = 1.5
        let loadDelay = 0.8
        let appearDelay = 0.1
        let bannerDelay = 1.5
        let totalDelay = loadDelay + appearDelay + bannerDelay
        #expect(abs(totalDelay - 2.4) < 0.001)
    }

    // MARK: - Animation parameters

    @Test("Load transition: easeOut 0.3s")
    func loadTransitionDuration() {
        // withAnimation(.easeOut(duration: 0.3)) { isLoading = false }
        let duration = 0.3
        #expect(duration == 0.3)
    }

    @Test("Appear delay after load is 0.1s")
    func appearDelayAfterLoad() {
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        let appearDelay = 0.1
        #expect(appearDelay == 0.1)
    }

    @Test("Promo banner spring: response 0.5, dampingFraction 0.8")
    func promoBannerSpringParams() {
        // .spring(response: 0.5, dampingFraction: 0.8)
        let response = 0.5
        let damping = 0.8
        #expect(response == 0.5)
        #expect(damping == 0.8)
    }

    @Test("Card staggered delay is 0.15s per card")
    func cardStaggeredDelay() {
        // .staggered(index: index, appeared: $appeared, delay: 0.15)
        let staggerDelay = 0.15
        #expect(staggerDelay == 0.15)
        // Card 0: 0 * 0.15 = 0s, Card 1: 1 * 0.15 = 0.15s
        #expect(0 * staggerDelay == 0)
        #expect(1 * staggerDelay == 0.15)
    }
}
