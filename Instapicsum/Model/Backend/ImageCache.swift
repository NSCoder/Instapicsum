//
//  ImageCache.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation
import SwiftUI

final actor ImageCache {
    enum ImageCacheError: Error {
        /// The server response if not a valid `UIImage`
        case invalidImageResponse(data: Data)
    }

    enum Status {
        case finished(UIImage)
        case loading(Task<UIImage, Error>)
        case error(Error)
    }

    private let backendAPI: BackendAPI
    private var cache: [URL: Status] = [:]

    /// Designated Initializer for `ImageCache` that allows customization of urlSession.
    /// - Parameters:
    ///   - urlSession: *Intended for tests* An URLSession instance to be used to make requests
    init(backendAPI: BackendAPI) {
        self.backendAPI = backendAPI
    }

    /// Obtain an image from the cache or the backend
    /// - Parameter photographURL: URL where the image is hosted
    func image(for photographURL: URL) async throws -> UIImage {
        if let cached = cache[photographURL] {
            switch cached {
            case .error(let error):
                throw error
            case .loading(let task):
                return try await task.value
            case .finished(let image):
                return image
            }
        }

        let downloadTask = downloadTask(for: photographURL)
        cache[photographURL] = .loading(downloadTask)

        do {
            let image = try await downloadTask.value
            cache[photographURL] = .finished(image)
            return image
        } catch {
            cache[photographURL] = .error(error)
            throw error
        }
    }

    private func downloadTask(for url: URL) -> Task<UIImage, Error> {
        return Task.detached { [unowned self] in
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
            let data = try await backendAPI.fetchData(with: request)

            guard let image = UIImage(data: data) else {
                throw ImageCacheError.invalidImageResponse(data: data)
            }
            return image
        }
    }
}
