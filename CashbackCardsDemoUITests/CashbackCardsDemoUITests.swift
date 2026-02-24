import XCTest

/// Base class for all UI tests with common setup and helpers.
class CashbackCardsDemoUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Helpers

    /// Waits for an element to exist within the given timeout.
    @discardableResult
    func waitForElement(
        _ element: XCUIElement,
        timeout: TimeInterval = 5
    ) -> Bool {
        element.waitForExistence(timeout: timeout)
    }

    /// Taps a button with the given label text.
    func tapButton(_ label: String) {
        let button = app.buttons[label]
        XCTAssertTrue(waitForElement(button), "Button '\(label)' not found")
        button.tap()
    }

    /// Waits for a static text to appear on screen.
    @discardableResult
    func waitForText(
        _ text: String,
        timeout: TimeInterval = 5
    ) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        let element = app.staticTexts.element(matching: predicate)
        return element.waitForExistence(timeout: timeout)
    }
}
