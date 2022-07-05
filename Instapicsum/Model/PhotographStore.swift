//
//  PhotographStore.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

final class PhotographStore: PhotographCollectionProvider, ObservableObject {
    let photographProvider: any PhotographCollectionProvider

    init(photographProvider: PhotographCollectionProvider = PicsumPhotographCollectionProvider()) {
        if ProcessInfo.processInfo.arguments.contains("XCTest") {
            self.photographProvider = StaticPhotographCollectionProvider()
        } else {
            self.photographProvider = photographProvider
        }
    }

    func photographs(for pageNumber: PageNumber) async throws -> [Photograph] {
        try await photographProvider.photographs(for: pageNumber)
    }
}
