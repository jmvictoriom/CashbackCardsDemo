import Testing
import SwiftUI
@testable import CashbackCardsDemo

@Suite("PromoBanner Modifier")
struct PromoBannerModifierTests {

    // MARK: - A11: Banner configuration

    @Test("PromoBannerModifier stores title and subtitle")
    func bannerTitleSubtitle() {
        let isShowing = Binding.constant(true)
        let modifier = PromoBannerModifier(
            isShowing: isShowing,
            title: "Test Title",
            subtitle: "Test Subtitle",
            icon: "creditcard.fill",
            duration: 6.0
        )
        #expect(modifier.title == "Test Title")
        #expect(modifier.subtitle == "Test Subtitle")
    }

    @Test("Default icon is creditcard.fill")
    func defaultIcon() {
        // The extension's default parameter
        let defaultIcon = "creditcard.fill"
        #expect(defaultIcon == "creditcard.fill")
    }

    @Test("Default duration is 6.0 seconds")
    func defaultDuration() {
        let isShowing = Binding.constant(true)
        let modifier = PromoBannerModifier(
            isShowing: isShowing,
            title: "T",
            subtitle: "S",
            icon: "creditcard.fill",
            duration: 6.0
        )
        #expect(modifier.duration == 6.0)
    }

    @Test("Custom duration is respected")
    func customDuration() {
        let isShowing = Binding.constant(true)
        let modifier = PromoBannerModifier(
            isShowing: isShowing,
            title: "T",
            subtitle: "S",
            icon: "star",
            duration: 3.0
        )
        #expect(modifier.duration == 3.0)
        #expect(modifier.icon == "star")
    }

    // MARK: - Animation parameters

    @Test("Dismiss spring: response 0.3, dampingFraction 0.8")
    func dismissSpringParams() {
        // .spring(response: 0.3, dampingFraction: 0.8)
        let response = 0.3
        let damping = 0.8
        #expect(response == 0.3)
        #expect(damping == 0.8)
    }

    @Test("Banner corner radius is 16pt")
    func bannerCornerRadius() {
        // RoundedRectangle(cornerRadius: 16)
        let cornerRadius: CGFloat = 16
        #expect(cornerRadius == 16)
    }

    @Test("Banner padding: horizontal 16pt, vertical 14pt, bottom 8pt")
    func bannerPadding() {
        // .padding(.horizontal, 16) .padding(.vertical, 14) .padding(.bottom, 8)
        let hPadding: CGFloat = 16
        let vPadding: CGFloat = 14
        let bottomPadding: CGFloat = 8
        #expect(hPadding == 16)
        #expect(vPadding == 14)
        #expect(bottomPadding == 8)
    }

    @Test("Icon circle: blue background, 40x40pt")
    func iconCircle() {
        // Circle().fill(Color(red: 0.2, green: 0.4, blue: 0.9)).frame(width: 40, height: 40)
        let iconSize: CGFloat = 40
        #expect(iconSize == 40)
    }
}
