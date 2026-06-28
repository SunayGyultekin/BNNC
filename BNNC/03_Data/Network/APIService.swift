//
//  APIService.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 27.06.26.
//

import Foundation

protocol APIService {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
