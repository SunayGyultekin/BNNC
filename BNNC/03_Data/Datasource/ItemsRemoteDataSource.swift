//
//  ItemsRemoteDataSource.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 28.06.26.
//

protocol ItemsRemoteDataSourceProtocol {
    // MARK: Methods
    func fetchItems() async throws -> [BinanceItemDTO]
}


final class ItemsRemoteDataSource: ItemsRemoteDataSourceProtocol {
    // MARK: Dependencies
    private let apiService: APIService
    
    // MARK: Init
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: Methods
    func fetchItems() async throws -> [BinanceItemDTO] {
        return try await apiService.request(endpoint: APIEndpoints.getItems)
    }
}
