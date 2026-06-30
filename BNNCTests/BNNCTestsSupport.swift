import Foundation
import SwiftUI
import Testing
@testable import BNNC

// Define minimal DTO and repository abstractions for tests if the app doesn't expose them to tests.
// If your app already defines these, the compiler will use the app's versions and these will be redundant.

// MARK: - Mock Errors
enum TestError: LocalizedError {
    case database
    case network
    
    var errorDescription: String? {
        switch self {
        case .database: return "Database error"
        case .network: return "Network unavailable"
        }
    }
}

// MARK: - Mock Repository
final class ItemsMockRepository: ItemsRepositoryProtocol {
    // MARK: Properties
    enum Call: Equatable {
        case cached
        case remote
    }
    private(set) var calls: [Call] = []
    private(set) var cachedItems: [BinanceItem] = []
    private(set) var remoteItems: [BinanceItem] = []
    private(set) var cachedError: Error?
    private(set) var remoteError: Error?
    
    init(cachedItems: [BinanceItem] = [], remoteItems: [BinanceItem] = [], cachedError: Error? = nil, remoteError: Error? = nil) {
        self.cachedItems = cachedItems
        self.remoteItems = remoteItems
        self.cachedError = cachedError
        self.remoteError = remoteError
    }
    
    // MARK: Methods
    func getCachedItems() async throws -> [BinanceItem] {
        calls.append(.cached)
        if let cachedError {
            throw cachedError
        }
        return cachedItems
    }
    
    func getRemoteItemsAndSync() async throws -> [BinanceItem] {
        calls.append(.remote)
        if let remoteError {
            throw remoteError
        }
        return remoteItems
    }
}


// MARK: - Mock BinanceItemns
extension BinanceItem {
    static var mockValue1: Self {
        return BinanceItem(symbol: "LSKETH",
                           priceChange: "0.00005230",
                           priceChangePercent: "18.351",
                           weightedAvgPrice: "0.00032651",
                           prevClosePrice: "0.00000000",
                           lastPrice: "0.00033730",
                           lastQty: "10.10000000",
                           bidPrice: "0.00000000",
                           bidQty: "0.00000000",
                           askPrice: "0.00000000",
                           askQty: "0.00000000",
                           openPrice: "0.00028500",
                           highPrice: "0.00037700",
                           lowPrice: "0.00027400",
                           volume: "249310.90000000",
                           quoteVolume: "81.40334598",
                           openTime: 1778168131241,
                           closeTime: 1778254531241,
                           firstId: 2906007,
                           lastId: 2910006,
                           count: 4000,
                           percentageColor: Color.green)
    }
    
    static var mockValue2: Self {
        return BinanceItem(symbol: "QKCETH",
                           priceChange: "-0.00000046",
                           priceChangePercent: "-9.664",
                           weightedAvgPrice: "0.00000429",
                           prevClosePrice: "0.00000000",
                           lastPrice: "0.00000430",
                           lastQty: "487.00000000",
                           bidPrice: "0.00000000",
                           bidQty: "0.00000000",
                           askPrice: "0.00000000",
                           askQty: "0.00000000",
                           openPrice: "0.00000476",
                           highPrice: "0.00000490",
                           lowPrice: "0.00000384",
                           volume: "31027875.00000000",
                           quoteVolume: "133.21057923",
                           openTime: 1778168131241,
                           closeTime: 1778254531241,
                           firstId: 3666634,
                           lastId: 3670633,
                           count: 4000,
                           percentageColor: Color.red)
    }
}
