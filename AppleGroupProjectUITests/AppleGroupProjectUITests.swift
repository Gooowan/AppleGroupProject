import XCTest

final class AppleGroupProjectUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAddQuoteSuccess() throws {
        app.navigationBars["Saved Quotes"].buttons["Add"].tap()

        let quoteTextView = app.textViews["quoteTextView"]
        let authorTextField = app.textFields["authorTextField"]
        let genreTextField = app.textFields["genreTextField"]

        XCTAssertTrue(quoteTextView.exists)
        XCTAssertTrue(authorTextField.exists)
        XCTAssertTrue(genreTextField.exists)

        quoteTextView.tap()
        quoteTextView.typeText("The way to get started is to quit talking and begin doing.")
        authorTextField.tap()
        authorTextField.typeText("Walt Disney")
        genreTextField.tap()
        genreTextField.typeText("Inspiration")

        app.buttons["saveButton"].tap()

        let successAlert = app.alerts["Success"]
        XCTAssertTrue(successAlert.exists)
        XCTAssertEqual(successAlert.label, "Success")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertFalse(successAlert.exists)
        }
    }
    
    func testAddQuoteError() throws {
        app.navigationBars["Saved Quotes"].buttons["Add"].tap()
        app.buttons["saveButton"].tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertEqual(errorAlert.exists, true)
        XCTAssertEqual(errorAlert.label, "Error")

        XCTAssertEqual(errorAlert.staticTexts["Please fill in all fields: quote, author, and genre."].exists, true)

        errorAlert.buttons["OK"].tap()
        XCTAssertEqual(errorAlert.exists, false)
    }
    
    func testAddQuoteCancel() throws {
        app.navigationBars["Saved Quotes"].buttons["Add"].tap()
        XCTAssertEqual(app.navigationBars["Add Quote"].exists, true)
        app.buttons["closeButton"].tap()
        XCTAssertEqual(app.navigationBars["Saved Quotes"].exists, true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
