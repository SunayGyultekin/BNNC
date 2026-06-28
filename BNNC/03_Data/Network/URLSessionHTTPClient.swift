//
//  URLSessionHTTPClient.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    // MARK: Properties
    private let session: URLSession
    
    // MARK: Init
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: Methods
    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await session.data(for: request)
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            return (data, http)
        } catch {
            throw NetworkError.transport(error)
        }
    }
}
