//
//  APIEndpoints.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

enum APIEndpoints: Endpoint {
    // MARK: Cases
    case getItems

    // MARK: Properties
    var path: String {
        switch self {
        case .getItems:
            return "/ticker/24hr"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getItems:
            return .get
        }
    }

    var queryItems: [URLQueryItem]? {
        return nil
        /// Implement if needed
    }

    var headers: [String : String] {
        return ["Content-Type": "application/json"]
    }

    var body: Data? {
        return nil
        /// Implement if needed
    }
}
