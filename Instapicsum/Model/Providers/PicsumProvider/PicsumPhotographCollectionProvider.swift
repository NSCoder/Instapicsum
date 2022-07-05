//
//  PicsumPhotographCollectionProvider.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

struct PicsumPhotographCollectionProvider: PhotographCollectionProvider {
    let backendAPI: BackendAPI

    init(urlSession: URLSessionRepresentable = URLSession.shared) {
        self.backendAPI = BackendAPI(urlSession: urlSession)
    }

    func photographs(for pageNumber: PageNumber) async throws -> [Photograph] {
        let photographsPerPage = Picsum.photographsPerPage
        let path = "v2/list/"
        var url = Picsum.baseURL.appendingPathComponent(path)
        url.append(queryItems: [
            URLQueryItem(name: "page", value: "\(pageNumber)"),
            URLQueryItem(name: "limit", value: "\(photographsPerPage)")
        ])

        let urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        return try await backendAPI.fetch(request: urlRequest)
    }
}
