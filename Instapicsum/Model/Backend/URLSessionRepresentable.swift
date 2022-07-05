//
//  URLSessionRepresentable.swift
//  Instapicsum
//
//  Created by Iker Karam on 7/4/22.
//

import Foundation

/// Allow `URLSession` to be dependency injected
/// - Note: Intended to be used for tests
protocol URLSessionRepresentable {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionRepresentable { }
