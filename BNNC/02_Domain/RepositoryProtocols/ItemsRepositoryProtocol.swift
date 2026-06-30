//
//  ItemsRepositoryProtocol.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

protocol ItemsRepositoryProtocol {
    // MARK: Methods
    func getCachedItems() async throws -> [BinanceItem]
    func getRemoteItemsAndSync() async throws -> [BinanceItem]
}
