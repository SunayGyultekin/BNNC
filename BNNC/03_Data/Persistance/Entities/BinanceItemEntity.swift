//
//  BinanceItemEntity.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

import Foundation
import SwiftData

@Model
class BinanceItemEntity {
    // MARK: Properties
    var symbol: String
    var priceChange: String
    var priceChangePercent: String
    var weightedAvgPrice: String
    var prevClosePrice: String
    var lastPrice: String
    var lastQty: String
    var bidPrice: String
    var bidQty: String
    var askPrice: String
    var askQty: String
    var openPrice: String
    var highPrice: String
    var lowPrice: String
    var volume: String
    var quoteVolume: String
    var openTime: Int
    var closeTime: Int
    var firstId: Int
    var lastId: Int
    var count: Int
    var updatedAt: Date
    
    // MARK: Init
    init(symbol: String, priceChange: String, priceChangePercent: String, weightedAvgPrice: String, prevClosePrice: String, lastPrice: String, lastQty: String, bidPrice: String, bidQty: String, askPrice: String, askQty: String, openPrice: String, highPrice: String, lowPrice: String, volume: String, quoteVolume: String, openTime: Int, closeTime: Int, firstId: Int, lastId: Int, count: Int, updatedAt: Date) {
        self.symbol = symbol
        self.priceChange = priceChange
        self.priceChangePercent = priceChangePercent
        self.weightedAvgPrice = weightedAvgPrice
        self.prevClosePrice = prevClosePrice
        self.lastPrice = lastPrice
        self.lastQty = lastQty
        self.bidPrice = bidPrice
        self.bidQty = bidQty
        self.askPrice = askPrice
        self.askQty = askQty
        self.openPrice = openPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.volume = volume
        self.quoteVolume = quoteVolume
        self.openTime = openTime
        self.closeTime = closeTime
        self.firstId = firstId
        self.lastId = lastId
        self.count = count
        self.updatedAt = updatedAt
    }
}


extension BinanceItemEntity {
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
}

