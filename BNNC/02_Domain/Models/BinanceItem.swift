//
//  BinanceItem.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation
import SwiftUI

struct BinanceItem: Identifiable, Hashable {
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
    let openTime: Int64
    let closeTime: Int64
    let firstId: Int
    let lastId: Int
    let count: Int
    let percentageColor: Color
    
    var properties: [OrderedProperty] {
        return [OrderedProperty(index: 0, key: "symbol", keyName: "Symmbol", value: symbol),
                OrderedProperty(index: 1, key: "priceChange", keyName: "Price change", value: priceChange),
                OrderedProperty(index: 2, key: "priceChangePercent", keyName: "Price change percent", value: "\(priceChangePercent)%"),
                OrderedProperty(index: 3, key: "weightedAvgPrice", keyName: "Weighted average price", value: weightedAvgPrice),
                OrderedProperty(index: 4, key: "prevClosePrice", keyName: "Previous close price", value: prevClosePrice),
                OrderedProperty(index: 5, key: "lastPrice", keyName: "Last price", value: lastPrice),
                OrderedProperty(index: 6, key: "lastQty", keyName: "Last quantity", value: lastQty),
                OrderedProperty(index: 7, key: "bidPrice", keyName: "Bid price", value: bidPrice),
                OrderedProperty(index: 8, key: "bidQty", keyName: "Bid quantity", value: bidQty),
                OrderedProperty(index: 9, key: "askPrice", keyName: "Ask price", value: askPrice),
                OrderedProperty(index: 10, key: "askQty", keyName: "Ask quantity", value: askQty),
                OrderedProperty(index: 11, key: "openPrice", keyName: "Open price", value: openPrice),
                OrderedProperty(index: 12, key: "highPrice", keyName: "High price", value: highPrice),
                OrderedProperty(index: 13, key: "lowPrice", keyName: "Low price", value: lowPrice),
                OrderedProperty(index: 14, key: "volume", keyName: "Volume", value: volume),
                OrderedProperty(index: 15, key: "quoteVolume", keyName: "Quote volume", value: quoteVolume),
                OrderedProperty(index: 16, key: "openTime", keyName: "Open time", value: Date(milliseconds: openTime).formatted()),
                OrderedProperty(index: 17, key: "closeTime", keyName: "Close time", value: Date(milliseconds: closeTime).formatted()),
                OrderedProperty(index: 18, key: "firstId", keyName: "First ID", value: String(firstId)),
                OrderedProperty(index: 19, key: "lastId", keyName: "Last ID", value: String(lastId)),
                OrderedProperty(index: 20, key: "count", keyName: "Count", value: String(count))]
    }
}

struct OrderedProperty: Hashable {
    // MARK: Properties
    var index: Int
    var key: String
    var keyName: String
    var value: String
}
