//
//  ItemsLocalDataSource.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

protocol ItemsLocalDataSourceProtocol {
    // MARK: Methods
    func fetchItems() async throws -> [BinanceItem]
    func saveItems(_ items: [BinanceItemDTO]) async throws
}


final class ItemsLocalDataSource: ItemsLocalDataSourceProtocol {
    // MARK: Dependencies
    private let actor: DatabaseActor

    // MARK: Init
    init(actor: DatabaseActor) {
        self.actor = actor
    }
    
    // MARK: Methods
    func fetchItems() async throws -> [BinanceItem] {
        try await actor.fetchItems().map { $0.toDomain() }
    }
    
    func saveItems(_ items: [BinanceItemDTO]) async throws {
        try await actor.save(items: items)
    }
}
