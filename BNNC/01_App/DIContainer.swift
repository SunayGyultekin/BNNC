//
//  DIContainer.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation
import SwiftData

final class DIContainer {
    // MARK: Networking
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient()
    }()
    private lazy var apiService: APIService = {
        APIClient(baseURL: URL(string: "https://api2.binance.com/api/v3")!,
                  httpClient: httpClient)
    }()
    // MARK: SwiftData
    private let modelContainer: ModelContainer
    
    // MARK: Init
    init() {
        do {
            modelContainer = try ModelContainer(for: BinanceItemEntity.self)
        } catch {
            fatalError("Unable to create ModelContainer: \(error)")
        }
    }
    
    // MARK: Database actor
    private lazy var dbActor: DatabaseActor = {
        DatabaseActor(modelContainer: modelContainer)
    }()
    
    // MARK: DataSources
    private lazy var localDataSource: ItemsLocalDataSourceProtocol = {
        ItemsLocalDataSource(actor: dbActor)
    }()
    
    private lazy var remoteDataSource: ItemsRemoteDataSourceProtocol = {
        ItemsRemoteDataSource(apiService: apiService)
    }()
    
    // MARK: Repository
    private lazy var itemsRepository: ItemsRepositoryProtocol = {
        ItemsRepository(local: localDataSource,
                        remote: remoteDataSource)
    }()
    
    // MARK: Use Cases
    func makeItemsUseCase() -> GetItemsUseCaseProtocol {
        GetItemsUseCase(repository: itemsRepository)
    }
    
    // MARK: ViewModels
    func makeItemsViewModel() -> ItemsVIewModel {
        ItemsVIewModel(getItemsUseCase: makeItemsUseCase())
    }
}
