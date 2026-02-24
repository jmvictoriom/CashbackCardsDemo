import XCTest

final class PromoBannerUITests: CashbackCardsDemoUITests {

    // MARK: - Toast and banner auto-dismiss

    func testCashbackToastAutoDismisses() throws {
        app.staticTexts["Cashback"].tap()

        // Dismiss onboarding
        let continueButton = app.buttons["Continuar"]
        if waitForElement(continueButton, timeout: 5) {
            continueButton.tap()
        }

        // Wait for toast to appear
        let toastText = app.staticTexts["Comparte con tus amigos y gana 50€ en cashback"]
        guard waitForElement(toastText, timeout: 8) else {
            XCTFail("Toast did not appear")
            return
        }

        // Toast auto-dismisses after 5s duration
        sleep(6)
        XCTAssertFalse(toastText.exists, "Toast should have auto-dismissed")
    }

    func testPromoBannerAutoDismisses() throws {
        app.staticTexts["Tus tarjetas"].tap()

        // Wait for promo banner
        let bannerText = app.staticTexts["Nueva Visa Travel disponible"]
        guard waitForElement(bannerText, timeout: 8) else {
            XCTFail("Banner did not appear")
            return
        }

        // Banner auto-dismisses after 6s default duration
        sleep(7)
        XCTAssertFalse(bannerText.exists, "Banner should have auto-dismissed")
    }

    func testCardsBannerSubtitleDisplayed() throws {
        app.staticTexts["Tus tarjetas"].tap()

        // Wait for banner subtitle
        XCTAssertTrue(
            waitForText("Solicítala ahora y viaja tranquilo", timeout: 8),
            "Banner subtitle should be visible"
        )
    }
}
