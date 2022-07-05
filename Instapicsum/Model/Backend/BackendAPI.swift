//
//  BackendAPI.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

struct BackendAPI {
    enum BackendError: Error {
        /// The endpoint request URL is invalid.
        case unableToCreateURLRequest(endpointURL: URL, queryItems: [URLQueryItem])
        /// The `URLSession` throw a URLError when processing a request
        case unableToProcessEndpointRequest(error: URLError)
        ///  The response is not a `HTTPURLResponse`
        case invalidHTTPResponse(response: URLResponse)
        /// The `HTTPURLResponse` status code is not between `200..<400`
        case failedEndpointResponse(statusCode: Int)
        /// The server response is not a valid JSON object
        case unrecognizedEndpointResponse(underlyingError: Error)
    }

    private let urlSession: URLSessionRepresentable

    /// Designated Initializer for `ImageCache` that allows customization of urlSession.
    /// - Parameters:
    ///   - urlSession: *Intended for tests* An URLSession instance to be used to make requests
    init(urlSession: URLSessionRepresentable) {
        self.urlSession = urlSession
    }

    /// Fetch a decodable object from a `URLRequest`
    /// - Parameter request: Endpoint request for the decodable object
    func fetch<T>(request: URLRequest) async throws -> T where T: Decodable {
        let data = try await fetchData(with: request)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    /// Fetch data from a `URLRequest`
    /// - Parameter request:  Endpoint request for the data
    func fetchData(with request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw BackendError.invalidHTTPResponse(response: response)
            }

            guard (200..<400).contains(response.statusCode) else {
                throw BackendError.failedEndpointResponse(statusCode: response.statusCode)
            }

            return data
        } catch let error as URLError {
            throw BackendError.unableToProcessEndpointRequest(error: error)
        } catch let error as DecodingError {
            throw BackendError.unrecognizedEndpointResponse(underlyingError: error)
        }
    }
}
