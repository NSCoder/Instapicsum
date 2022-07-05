//
//  InstapicsumUITests.swift
//  InstapicsumUITests
//
//  Created by Iker Karam on 7/4/22.
//

import XCTest

final class InstapicsumUITests: XCTestCase {
    func testLandscapePhotograph() throws {
        let app = XCUIApplication()
        app.launchArguments = ["XCTest"]
        app.launch()

        let landscapePhotographID = "1002"

        let photographTile = app.buttons[landscapePhotographID]
        photographTile.tap()

        let authorText = app.staticTexts["NASA"]
        let photographImage = app.images[landscapePhotographID]
        XCTAssert(authorText.exists)
        XCTAssert(photographImage.exists)

        let photographFrame = photographImage.frame
        XCTAssert(photographFrame.width >= photographFrame.height)
    }

    func testPortraitPhotograph() {
        let app = XCUIApplication()
        app.launchArguments = ["XCTest"]
        app.launch()

        let landscapePhotographID = "1009"

        let photographTile = app.buttons[landscapePhotographID]
        photographTile.tap()

        let authorText = app.staticTexts["Christopher Campbell"]
        let photographImage = app.images[landscapePhotographID]
        XCTAssert(authorText.exists)
        XCTAssert(photographImage.exists)

        let photographFrame = photographImage.frame
        XCTAssert(photographFrame.width <= photographFrame.height)
    }
}
