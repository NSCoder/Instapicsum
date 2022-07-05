//
//  StaticPhotographCollectionProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

/// Provides photograph collection support for previews and tests using the Preview Assets Catalog
struct StaticPhotographCollectionProvider: PhotographCollectionProvider {
    func photographs(for pageNumber: PageNumber) async throws -> [Photograph] {
        let assetName = "PhotographCollection"
        guard let asset = NSDataAsset(name: assetName) else {
            throw StaticProviderError.unableToLoadAsset(named: assetName)
        }
        return try JSONDecoder().decode([Photograph].self, from: asset.data)
    }
}

// MARK: - Extra preview functionality
extension StaticPhotographCollectionProvider {
    /// Get a portrait photograph
    func anyPortraitPhotograph() throws -> Photograph {
        try photograph(forAssetName: "PortraitPhotograph")
    }

    /// Get a landscape photograph
    func anyLandscapePhotograph() throws -> Photograph {
        try photograph(forAssetName: "LandscapePhotograph")
    }

    private func photograph(forAssetName assetName: String) throws -> Photograph {
        guard let dataAsset = NSDataAsset(name: assetName) else {
            throw StaticProviderError.unableToLoadAsset(named: assetName)
        }
        return try JSONDecoder().decode(Photograph.self, from: dataAsset.data)
    }
}
