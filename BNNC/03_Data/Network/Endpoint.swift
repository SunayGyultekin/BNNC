//
//  Endpoint.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

protocol Endpoint {
    // MARK: Properties
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String] { get }
    var body: Data? { get }
}
