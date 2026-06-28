//
//  NetworkError.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

enum NetworkError: LocalizedError {
    // MARK: Cases
    case invalidURL
    case invalidResponse
    case unauthorized
    case forbidden
    case notFound
    case serverError(Int)
    case decoding(Error)
    case transport(Error)
    case unknown

    // MARK: Description
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid server response."
        case .unauthorized:
            return "Unauthorized."
        case .forbidden:
            return "Forbidden."
        case .notFound:
            return "Resource not found."
        case .serverError(let code):
            return "Server error \(code)."
        case .decoding(let error):
            return error.localizedDescription
        case .transport(let error):
            return error.localizedDescription
        case .unknown:
            return "Unknown error."
        }
    }
}
