//
//  PhotographsProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

typealias PageNumber = Int

protocol PhotographsProvider {
    func photographs(for pageNumber: PageNumber) async throws -> [Photograph]
}
