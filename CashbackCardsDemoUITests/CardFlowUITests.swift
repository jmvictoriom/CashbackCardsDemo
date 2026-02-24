import XCTest

final class CardFlowUITests: CashbackCardsDemoUITests {

    // MARK: - Navigation to Cards

    func testNavigateToCardsList() throws {
        // Tap "Tus tarjetas" from home
        let cardsCard = app.staticTexts["Tus tarjetas"]
        XCTAssertTrue(waitForElement(cardsCard, timeout: 3))
        cardsCard.tap()

        // Wait for loading to finish and cards to appear
        let debitLabel = app.staticTexts["Tarjeta de débito"]
        XCTAssertTrue(waitForElement(debitLabel, timeout: 5))
    }

    func testCardsListShowsDebitAndCredit() throws {
        app.staticTexts["Tus tarjetas"].tap()

        // Both card types should appear after loading
        XCTAssertTrue(waitForText("**** 1093", timeout: 5))
        XCTAssertTrue(waitForText("**** 0221", timeout: 3))
    }

    // MARK: - A15: Card flip

    func testCardDetailFlip() throws {
        // Navigate: Home → Cards → First card
        app.staticTexts["Tus tarjetas"].tap()

        // Wait for cards to load
        let debitText = app.staticTexts["**** 1093"]
        XCTAssertTrue(waitForElement(debitText, timeout: 5))
        debitText.tap()

        // In detail view, tap the refresh/flip button
        let refreshButton = app.buttons["arrow.clockwise"]
        if waitForElement(refreshButton, timeout: 3) {
            refreshButton.tap()

            // After flip, "VALID THRU" text should appear (card back)
            XCTAssertTrue(waitForText("VALID THRU", timeout: 3))
        }
    }

    func testCardDetailShowsSpentAmount() throws {
        app.staticTexts["Tus tarjetas"].tap()
        let debitText = app.staticTexts["**** 1093"]
        XCTAssertTrue(waitForElement(debitText, timeout: 5))
        debitText.tap()

        // "Gastado este mes" label should be visible
        XCTAssertTrue(waitForText("Gastado este mes", timeout: 3))
    }

    // MARK: - A18/A19: Customize

    func testNavigateToCustomize() throws {
        app.staticTexts["Tus tarjetas"].tap()
        let debitText = app.staticTexts["**** 1093"]
        XCTAssertTrue(waitForElement(debitText, timeout: 5))
        debitText.tap()

        // Tap "Personalizar" button
        let customizeButton = app.buttons["Personalizar"]
        XCTAssertTrue(waitForElement(customizeButton, timeout: 3))
        customizeButton.tap()

        // Customize screen should show title text
        XCTAssertTrue(waitForText("Selecciona tu", timeout: 3))
    }

    func testCustomizeShowsConfirmButton() throws {
        app.staticTexts["Tus tarjetas"].tap()
        let debitText = app.staticTexts["**** 1093"]
        XCTAssertTrue(waitForElement(debitText, timeout: 5))
        debitText.tap()

        app.buttons["Personalizar"].tap()
        let confirmButton = app.buttons["Confirmar"]
        XCTAssertTrue(waitForElement(confirmButton, timeout: 3))
    }

    // MARK: - A11: Promo banner

    func testPromoBannerAppearsOnCardsList() throws {
        app.staticTexts["Tus tarjetas"].tap()

        // Promo banner appears ~2.3s after view loads
        XCTAssertTrue(waitForText("Nueva Visa Travel disponible", timeout: 8))
    }

    func testPromoBannerCanBeDismissed() throws {
        app.staticTexts["Tus tarjetas"].tap()

        // Wait for banner to appear
        let bannerText = app.staticTexts["Nueva Visa Travel disponible"]
        guard waitForElement(bannerText, timeout: 8) else {
            XCTFail("Banner did not appear")
            return
        }

        // Dismiss banner via xmark button
        let dismissButton = app.buttons["xmark"]
        if waitForElement(dismissButton, timeout: 2) {
            dismissButton.tap()
            // Banner text should disappear
            sleep(1)
            XCTAssertFalse(bannerText.exists)
        }
    }
}
