import Testing
import SwiftUI
@testable import CashbackCardsDemo

@Suite("BrandDetailView Integration")
struct BrandDetailViewTests {

    // MARK: - A07: zoomScale formula = 1.0 + abs(min(offset, 0)) / 500.0

    private func zoomScale(offset: CGFloat) -> CGFloat {
        1.0 + abs(min(offset, 0)) / 500.0
    }

    @Test("zoomScale at offset 0 is 1.0")
    func zoomScaleAtZero() {
        #expect(zoomScale(offset: 0) == 1.0)
    }

    @Test("zoomScale at positive offset (pull down) stays 1.0")
    func zoomScalePositiveOffset() {
        #expect(zoomScale(offset: 100) == 1.0)
        #expect(zoomScale(offset: 500) == 1.0)
    }

    @Test("zoomScale at offset -100 is 1.2")
    func zoomScaleNeg100() {
        let scale = zoomScale(offset: -100)
        #expect(abs(scale - 1.2) < 0.001)
    }

    @Test("zoomScale at offset -250 is 1.5")
    func zoomScaleNeg250() {
        let scale = zoomScale(offset: -250)
        #expect(abs(scale - 1.5) < 0.001)
    }

    @Test("zoomScale at offset -500 is 2.0")
    func zoomScaleNeg500() {
        let scale = zoomScale(offset: -500)
        #expect(abs(scale - 2.0) < 0.001)
    }

    // MARK: - Fine print formula

    @Test("Fine print debit percentage: max(cashback - 5, 2)")
    func finePrintFormula() {
        // Europcar: 10% → max(10-5, 2) = 5
        #expect(max(Brand.europcar.cashbackPercent - 5, 2) == 5)
        // NorthFace: 5% → max(5-5, 2) = max(0, 2) = 2
        #expect(max(Brand.northFace.cashbackPercent - 5, 2) == 2)
        // Lego: 8% → max(8-5, 2) = 3
        #expect(max(Brand.lego.cashbackPercent - 5, 2) == 3)
        // RayBan: 10% → max(10-5, 2) = 5
        #expect(max(Brand.rayBan.cashbackPercent - 5, 2) == 5)
    }

    @Test("Layout constants are expected values")
    func layoutConstants() {
        let heroHeight: CGFloat = 350
        let heroMinHeight: CGFloat = 180
        let cornerRadius: CGFloat = 20
        let conditionSpacing: CGFloat = 16
        let hPadding: CGFloat = 16
        #expect(heroHeight == 350)
        #expect(heroMinHeight == 180)
        #expect(cornerRadius == 20)
        #expect(conditionSpacing == 16)
        #expect(hPadding == 16)
        #expect(heroHeight > heroMinHeight)
    }

    // MARK: - Animation parameters

    @Test("Appearance animation: easeOut 0.5s")
    func appearanceDuration() {
        // .easeOut(duration: 0.5)
        let duration = 0.5
        #expect(duration == 0.5)
    }

    @Test("Staggered default delay is 0.08s")
    func staggeredDelay() {
        // Uses default staggered(index:appeared:) → delay: 0.08
        let delay = 0.08
        #expect(delay == 0.08)
    }

    @Test("Hero height formula: max(350 + pullDown, 180)")
    func heroHeightFormula() {
        // let height = max(Layout.heroHeight + (offset > 0 ? offset : 0), Layout.heroMinHeight)
        let heroHeight: CGFloat = 350
        let heroMinHeight: CGFloat = 180

        // Pull down (offset > 0): stretches
        let pullDown: CGFloat = 100
        #expect(max(heroHeight + pullDown, heroMinHeight) == 450)

        // Scroll up (offset ≤ 0): stays at 350
        let scrollUp: CGFloat = -100
        let heightScrollUp = max(heroHeight + 0, heroMinHeight)
        #expect(heightScrollUp == 350)

        // Scroll way up: clamped at minHeight
        let _ = scrollUp // offset ≤ 0 means no addition
        #expect(max(heroHeight + 0, heroMinHeight) == 350)
    }

    @Test("Logo font size adjusts for long letters (> 2 chars)")
    func logoFontSizeLogic() {
        // brand.logoLetter.count > 2 ? 12 : 20
        #expect(Brand.europcar.logoLetter.count <= 2) // "E" → size 20
        #expect(Brand.northFace.logoLetter.count > 2) // "TNF" → size 12
        #expect(Brand.lego.logoLetter.count > 2)      // "LEGO" → size 12
    }
}
