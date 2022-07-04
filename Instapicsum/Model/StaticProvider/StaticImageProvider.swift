//
//  StaticImageProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

/// Provides image support for previews and tests using the Preview Assets Catalog
struct StaticImageProvider: ImageProvider {
    func image(for photograph: Photograph) async throws -> UIImage {
        let assetName =  "Images/\(photograph.id)"
        guard let image = UIImage(named: assetName) else {
            throw StaticProviderError.unableToLoadAsset(named: assetName)
        }
        return image
    }

    func thumbnailImage(for photograph: Photograph) async throws -> UIImage {
        let assetName =  "Thumbnails/\(photograph.id)"
        guard let image = UIImage(named: assetName) else {
            throw StaticProviderError.unableToLoadAsset(named: assetName)
        }
        return image
    }
}
