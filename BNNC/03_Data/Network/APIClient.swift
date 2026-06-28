//
//  APIClient.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

final class APIClient: APIService {
    // MARK: Properties
    private let baseURL: URL
    private let httpClient: HTTPClient
    private let decoder: JSONDecoder
    
    // MARK: Init
    init(baseURL: URL, httpClient: HTTPClient, decoder: JSONDecoder = JSONDecoder()) {
        self.baseURL = baseURL
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    // MARK: Methods
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let request = try validateRequest(endpoint)
        let (data, response) = try await httpClient.send(request)
        try validateResponse(response)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}

private extension APIClient {
    /// Validate params and return URLRequest
    func validateRequest(_ endpoint: Endpoint) throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path),
                                             resolvingAgainstBaseURL: false
        ) else {
            throw NetworkError.invalidURL
        }

        components.queryItems = endpoint.queryItems
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        endpoint.headers.forEach {
            request.setValue(
                $0.value,
                forHTTPHeaderField: $0.key
            )
        }
        return request
    }

    /// Validate response using status code
    func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
        case 200...299:
            return
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.serverError(response.statusCode)
        }
    }
}
