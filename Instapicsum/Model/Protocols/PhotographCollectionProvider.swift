//
//  PhotographCollectionProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

typealias PageNumber = Int

/// Declares the necessary functions to provide a paginated
/// collection of `Photograph`s
protocol PhotographCollectionProvider {
    /// Obtain a collection of photographs for a given page number
    func photographs(for pageNumber: PageNumber) async throws -> [Photograph]
}
