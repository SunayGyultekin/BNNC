//
//  DatabaseActor.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

import Foundation
import SwiftData

@ModelActor
actor DatabaseActor {
    func fetchItems() throws -> [BinanceItemEntity] {
        let descriptor = FetchDescriptor<BinanceItemEntity>()
        return try modelContext.fetch(descriptor)
    }
    
    func synchronize(items: [BinanceItemDTO]) async throws {
        let localItems = try modelContext.fetch(
            FetchDescriptor<BinanceItemEntity>()
        )
        // O(1) lookup
        var localItemsBySymbol = Dictionary(
            uniqueKeysWithValues: localItems.map { ($0.symbol, $0) }
        )

        let remoteSymbols = Set(items.map(\.symbol))
        
        for dto in items {
            if let entity = localItemsBySymbol[dto.symbol] {
                entity.apply(dto)
            } else {
                let entity = await dto.toEntity()
                modelContext.insert(entity)
                localItemsBySymbol[dto.symbol] = entity
            }
        }
        
        for entity in localItems where !remoteSymbols.contains(entity.symbol) {
            modelContext.delete(entity)
        }
        
        try modelContext.save()
    }
}
