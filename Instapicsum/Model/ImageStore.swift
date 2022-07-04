//
//  ImageStore.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

final class ImageStore: ImageProvider, ObservableObject {
    let imageProvider: any ImageProvider

    init(imageProvider: ImageProvider = StaticImageProvider()) {
        self.imageProvider = imageProvider
    }

    func thumbnailImage(for photograph: Photograph) async throws -> UIImage {
        try await imageProvider.thumbnailImage(for: photograph)
    }

    func image(for photograph: Photograph) async throws -> UIImage {
        try await imageProvider.image(for: photograph)
    }
}
