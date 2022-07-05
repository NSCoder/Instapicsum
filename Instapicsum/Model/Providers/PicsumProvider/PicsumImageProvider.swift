//
//  PicsumImageProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

struct PicsumImageProvider: ImageProvider {
    let imageCache: ImageCache

    init(urlSession: URLSessionRepresentable = URLSession.shared) {
        let backendAPI = BackendAPI(urlSession: urlSession)
        self.imageCache = ImageCache(backendAPI: backendAPI)
    }

    func thumbnailImage(for photograph: Photograph) async throws -> UIImage {
        let thumbnailSize = Picsum.thumbnailSize
        let thumbnailURL = Picsum.baseURL
            .appendingPathComponent("id")
            .appendingPathComponent(photograph.id)
            .appendingPathComponent("\(thumbnailSize)")

        return try await imageCache.image(for: thumbnailURL)
    }

    func image(for photograph: Photograph) async throws -> UIImage {
        try await imageCache.image(for: photograph.downloadURL)
    }
}
