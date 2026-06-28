//
//  BinanceItem.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

struct BinanceItem: Identifiable {
    // MARK: Properties
    let id: UUID = UUID()
    let symbol: String
    let priceChange: String
    let priceChangePercent: String
    let weightedAvgPrice: String
    let prevClosePrice: String
    let lastPrice: String
    let lastQty: String
    let bidPrice: String
    let bidQty: String
    let askPrice: String
    let askQty: String
    let openPrice: String
    let highPrice: String
    let lowPrice: String
    let volume: String
    let quoteVolume: String
    let openTime: Int
    let closeTime: Int
    let firstId: Int
    let lastId: Int
    let count: Int
}
