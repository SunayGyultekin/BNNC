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
        let descriptor = FetchDescriptor<BinanceItemEntity>(sortBy: [SortDescriptor(\.updatedAt)])
        return try modelContext.fetch(descriptor)
    }
    
    func save(items: [BinanceItemDTO]) throws {
        // One database query
        let existing = try modelContext.fetch(
            FetchDescriptor<BinanceItemEntity>()
        )
        // O(1) lookup
        var existingBySymbol = Dictionary(
            uniqueKeysWithValues: existing.map { ($0.symbol, $0) }
        )

        for dto in items {
            if let entity = existingBySymbol[dto.symbol] {
                entity.updatedAt = dto.updatedAt
                // Update only if necessary
                if entity.symbol != dto.symbol {
                    entity.symbol = dto.symbol
                }
            } else {
                let entity = dto.toEntity()
                modelContext.insert(entity)
                existingBySymbol[dto.symbol] = entity
            }
        }
        try modelContext.save()
    }
}
