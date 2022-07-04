//
//  StaticPhotographCollectionProviderTests.swift
//  InstapicsumTests
//
//  Created by Iker Karam on 7/4/22.
//

import XCTest
@testable import Instapicsum

final class StaticPhotographCollectionProviderTests: XCTestCase {
    let photographCollectionProvider = StaticPhotographCollectionProvider()
    
    func testPhotographsProvider() async throws {
        let photographs = try await photographCollectionProvider.photographs(for: 0)
        XCTAssert(photographs.count > 0)
    }

    func testAnyLandscapePhotograph() throws {
        let photograph = try photographCollectionProvider.anyLandscapePhotograph()
        XCTAssertNotNil(photograph)
    }

    func testAnyPortraitPhotograph() throws {
        let photograph = try photographCollectionProvider.anyPortraitPhotograph()
        XCTAssertNotNil(photograph)
    }
}
