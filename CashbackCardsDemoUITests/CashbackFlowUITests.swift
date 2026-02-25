import XCTest

final class CashbackFlowUITests: CashbackCardsDemoUITests {

    // MARK: - A01: Onboarding

    func testOnboardingSheetAppears() throws {
        // Tap Cashback from home
        let cashbackCard = app.staticTexts["Cashback"]
        XCTAssertTrue(waitForElement(cashbackCard, timeout: 3))
        cashbackCard.tap()

        // Onboarding sheet should appear with "Continuar" button
        XCTAssertTrue(waitForText("Compra más y gasta menos", timeout: 5))
    }

    func testOnboardingDismissWithContinue() throws {
        app.staticTexts["Cashback"].tap()

        // Wait for onboarding and dismiss
        let continueButton = app.buttons["Continuar"]
        XCTAssertTrue(waitForElement(continueButton, timeout: 5))
        continueButton.tap()

        // After dismiss, savings section should be visible
        XCTAssertTrue(waitForText("Este mes has", timeout: 5))
    }

    // MARK: - A07: Brand detail scroll

    func testNavigateToBrandDetail() throws {
        app.staticTexts["Cashback"].tap()

        // Dismiss onboarding first
        let continueButton = app.buttons["Continuar"]
        if waitForElement(continueButton, timeout: 5) {
            continueButton.tap()
        }

        // Wait for content to load, then tap a featured brand
        let destacados = app.staticTexts["Destacados"]
        XCTAssertTrue(waitForElement(destacados, timeout: 5))

        // Tap on a brand card (Europcar)
        let brandText = app.staticTexts["Europcar"]
        if waitForElement(brandText, timeout: 3) {
            brandText.tap()

            // Brand detail should show cashback badge
            XCTAssertTrue(waitForText("cashback", timeout: 5))
        }
    }

    // MARK: - Full cashback flow

    func testCashbackSavingsDisplayed() throws {
        app.staticTexts["Cashback"].tap()

        // Dismiss onboarding
        let continueButton = app.buttons["Continuar"]
        if waitForElement(continueButton, timeout: 5) {
            continueButton.tap()
        }

        // Wait for savings to load
        XCTAssertTrue(waitForText("Este mes has", timeout: 5))
        XCTAssertTrue(waitForText("Total", timeout: 3))
    }

    func testCashbackToastAppears() throws {
        app.staticTexts["Cashback"].tap()

        // Dismiss onboarding
        let continueButton = app.buttons["Continuar"]
        if waitForElement(continueButton, timeout: 5) {
            continueButton.tap()
        }

        // Toast appears ~2.2s after content loads
        XCTAssertTrue(waitForText("Comparte con tus amigos", timeout: 8))
    }
}
