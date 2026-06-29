//
//  BinanceItemEntity.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class BinanceItemEntity {
    // MARK: Properties
    @Attribute(.unique)
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
    var openTime: Int64
    var closeTime: Int64
    var firstId: Int
    var lastId: Int
    var count: Int
    
    // MARK: Init
    init(symbol: String, priceChange: String, priceChangePercent: String, weightedAvgPrice: String, prevClosePrice: String, lastPrice: String, lastQty: String, bidPrice: String, bidQty: String, askPrice: String, askQty: String, openPrice: String, highPrice: String, lowPrice: String, volume: String, quoteVolume: String, openTime: Int64, closeTime: Int64, firstId: Int, lastId: Int, count: Int) {
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
                           count: count,
                           percentageColor: priceChangePercent.getChangeColor())
    }
    
    @discardableResult
    func apply(_ dto: BinanceItemDTO) -> Bool {
        guard !isEqual(to: dto)
        else { return false }
        
        priceChange = dto.priceChange
        priceChangePercent = dto.priceChangePercent
        weightedAvgPrice = dto.weightedAvgPrice
        prevClosePrice = dto.prevClosePrice
        lastPrice = dto.lastPrice
        lastQty = dto.lastQty
        bidPrice = dto.bidPrice
        bidQty = dto.bidQty
        askPrice = dto.askPrice
        askQty = dto.askQty
        openPrice = dto.openPrice
        highPrice = dto.highPrice
        lowPrice = dto.lowPrice
        volume = dto.volume
        quoteVolume = dto.quoteVolume
        openTime = dto.openTime
        closeTime = dto.closeTime
        firstId = dto.firstId
        lastId = dto.lastId
        count = dto.count
        return true
    }
    
    func isEqual(to dto: BinanceItemDTO) -> Bool {
        symbol == dto.symbol &&
        priceChange == dto.priceChange &&
        priceChangePercent == dto.priceChangePercent &&
        weightedAvgPrice == dto.weightedAvgPrice &&
        prevClosePrice == dto.prevClosePrice &&
        lastPrice == dto.lastPrice &&
        lastQty == dto.lastQty &&
        bidPrice == dto.bidPrice &&
        bidQty == dto.bidQty &&
        askPrice == dto.askPrice &&
        askQty == dto.askQty &&
        openPrice == dto.openPrice &&
        highPrice == dto.highPrice &&
        lowPrice == dto.lowPrice &&
        volume == dto.volume &&
        quoteVolume == dto.quoteVolume &&
        openTime == dto.openTime &&
        closeTime == dto.closeTime &&
        firstId == dto.firstId &&
        lastId == dto.lastId &&
        count == dto.count
    }
}
