//
//  BinanceItemDTO.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

struct BinanceItemDTO: Codable {
    // MARK: Properties
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
    let updatedAt: Date = Date()
}

extension BinanceItemDTO {
    func toDomain() -> BinanceItem {
        return BinanceItem(symbol: symbol,
                           priceChange: priceChange,
                           priceChangePercent: priceChangePercent,
                           weightedAvgPrice: weightedAvgPrice,
                           prevClosePrice: prevClosePrice,
                           lastPrice: lastPrice,
                           lastQty: lastQty,
                           bidPrice: bidPrice,
                           bidQty: bidQty,
                           askPrice: askPrice,
                           askQty: askQty,
                           openPrice: openPrice,
                           highPrice: highPrice,
                           lowPrice: lowPrice,
                           volume: volume,
                           quoteVolume: quoteVolume,
                           openTime: openTime,
                           closeTime: closeTime,
                           firstId: firstId,
                           lastId: lastId,
                           count: count)
    }
    
    func toEntity() -> BinanceItemEntity {
        return BinanceItemEntity(symbol: symbol,
                                 priceChange: priceChange,
                                 priceChangePercent: priceChangePercent,
                                 weightedAvgPrice: weightedAvgPrice,
                                 prevClosePrice: prevClosePrice,
                                 lastPrice: lastPrice,
                                 lastQty: lastQty,
                                 bidPrice: bidPrice,
                                 bidQty: bidQty,
                                 askPrice: askPrice,
                                 askQty: askQty,
                                 openPrice: openPrice,
                                 highPrice: highPrice,
                                 lowPrice: lowPrice,
                                 volume: volume,
                                 quoteVolume: quoteVolume,
                                 openTime: openTime,
                                 closeTime: closeTime,
                                 firstId: firstId,
                                 lastId: lastId,
                                 count: count,
                                 updatedAt: updatedAt)
    }
}
