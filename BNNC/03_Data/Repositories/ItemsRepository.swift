//
//  ItemsRepository.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 27.06.26.
//

internal import Combine
import CoreData

final class ItemsRepository: ItemsRepositoryProtocol {
    // MARK: Dependencies
    private let local: ItemsLocalDataSourceProtocol
    private let remote: ItemsRemoteDataSourceProtocol
    
    // MARK: Init
    init(local: ItemsLocalDataSourceProtocol, remote: ItemsRemoteDataSourceProtocol) {
        self.local = local
        self.remote = remote
    }
    
    // MARK: Methods
    func getCachedItems() async throws -> [BinanceItem] {
        try await local.fetchItems()
    }
    
    func getRemoteItemsAndSync() async throws -> [BinanceItem] {
        let remoteItems = try await remote.fetchItems()
        try await local.saveItems(remoteItems)
        return try await local.fetchItems()
    }
}
