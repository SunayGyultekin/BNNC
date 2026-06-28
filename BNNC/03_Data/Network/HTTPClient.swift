//
//  HTTPClient.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

protocol HTTPClient {
    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
