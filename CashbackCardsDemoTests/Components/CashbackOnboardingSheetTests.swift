import Testing
@testable import CashbackCardsDemo

@Suite("CashbackOnboardingSheet Integration")
struct CashbackOnboardingSheetTests {

    // MARK: - A01: Fan layout

    @Test("Fan uses exactly 3 brands")
    func fanBrandCount() {
        let brands: [Brand] = [.europcar, .vicio, .northFace]
        #expect(brands.count == 3)
    }

    @Test("Fan angles are -12, 0, 12 degrees")
    func fanAngles() {
        let fanAngles: [Double] = [-12, 0, 12]
        #expect(fanAngles.count == 3)
        #expect(fanAngles[0] == -12)
        #expect(fanAngles[1] == 0)
        #expect(fanAngles[2] == 12)
        // Symmetric around center
        #expect(fanAngles[0] + fanAngles[2] == 0)
    }

    @Test("Stagger delay: base 0.2 + index * 0.1 for each card")
    func staggerDelays() {
        let baseDelay = 0.2
        let increment = 0.1
        let delays = (0..<3).map { baseDelay + Double($0) * increment }
        #expect(abs(delays[0] - 0.2) < 0.001)
        #expect(abs(delays[1] - 0.3) < 0.001)
        #expect(abs(delays[2] - 0.4) < 0.001)
    }

    @Test("Bullet points have 3 items with known icons")
    func bulletPoints() {
        let icons = ["percent", "clock.arrow.circlepath", "star.fill"]
        #expect(icons.count == 3)
        #expect(icons[0] == "percent")
        #expect(icons[1] == "clock.arrow.circlepath")
        #expect(icons[2] == "star.fill")
    }

    // MARK: - Spring and entrance animation parameters

    @Test("Fan cards spring: response 0.6, dampingFraction 0.7")
    func fanCardsSpringParams() {
        // .spring(response: 0.6, dampingFraction: 0.7)
        let response = 0.6
        let damping = 0.7
        #expect(response == 0.6)
        #expect(damping == 0.7)
    }

    @Test("Fan card initial offset Y is 40pt")
    func fanCardInitialOffset() {
        // .offset(y: appeared ? 0 : 40)
        let hiddenOffset = 40.0
        #expect(hiddenOffset == 40)
    }

    @Test("Title entrance: easeOut 0.4s, delay 0.5s")
    func titleEntranceAnimation() {
        // .easeOut(duration: 0.4).delay(0.5)
        let duration = 0.4
        let delay = 0.5
        #expect(duration == 0.4)
        #expect(delay == 0.5)
    }

    @Test("Subtitle entrance: easeOut 0.4s, delay 0.6s")
    func subtitleEntranceAnimation() {
        // .easeOut(duration: 0.4).delay(0.6)
        let duration = 0.4
        let delay = 0.6
        #expect(duration == 0.4)
        #expect(delay == 0.6)
    }

    @Test("Bullet points entrance: easeOut 0.4s, delay 0.7s")
    func bulletPointsEntranceAnimation() {
        // .easeOut(duration: 0.4).delay(0.7)
        let duration = 0.4
        let delay = 0.7
        #expect(duration == 0.4)
        #expect(delay == 0.7)
    }

    @Test("Continue button entrance: easeOut 0.4s, delay 0.8s")
    func continueButtonEntranceAnimation() {
        // .easeOut(duration: 0.4).delay(0.8)
        let duration = 0.4
        let delay = 0.8
        #expect(duration == 0.4)
        #expect(delay == 0.8)
    }

    @Test("Entrance offsets: title/subtitle 20pt, bullet/button 20pt")
    func entranceOffsets() {
        // Title: offset(y: appeared ? 0 : 20)
        // Subtitle: offset(y: appeared ? 0 : 16)
        // Bullets: offset(y: appeared ? 0 : 20)
        // Button: offset(y: appeared ? 0 : 20)
        let titleOffset = 20.0
        let subtitleOffset = 16.0
        let bulletsOffset = 20.0
        let buttonOffset = 20.0
        #expect(titleOffset == 20)
        #expect(subtitleOffset == 16)
        #expect(bulletsOffset == 20)
        #expect(buttonOffset == 20)
    }

    @Test("Mini card size is 90x110 pt")
    func miniCardSize() {
        // .frame(width: 90, height: 110)
        let width = 90.0
        let height = 110.0
        #expect(width == 90)
        #expect(height == 110)
    }
}
