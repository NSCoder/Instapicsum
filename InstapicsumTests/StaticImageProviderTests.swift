//
//  StaticImageProviderTests.swift
//  InstapicsumTests
//
//  Created by Iker Karam on 7/4/22.
//

import XCTest
@testable import Instapicsum

final class StaticImageProviderTests: XCTestCase {
    let photographCollection = StaticPhotographCollectionProvider()
    let imageProvider = StaticImageProvider()

    func testImageProvider() async throws {
        let photograph = try photographCollection.anyLandscapePhotograph()
        XCTAssertNotNil(photograph)

        let thumbnail = try await imageProvider.thumbnailImage(for: photograph)
        XCTAssertNotNil(thumbnail)

        XCTAssertEqual(thumbnail.size.width, 300)
        XCTAssertEqual(thumbnail.size.height, 300)

        let image = try await imageProvider.image(for: photograph)
        XCTAssertNotNil(image)
        XCTAssertGreaterThan(image.size.width, 300)
        XCTAssertGreaterThan(image.size.height, 300)
    }
}
