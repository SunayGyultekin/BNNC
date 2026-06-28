//
//  GetItemsUseCase.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

protocol GetItemsUseCaseProtocol {
    func execute() async -> AsyncThrowingStream<[BinanceItem], Error>
}


final class GetItemsUseCase: GetItemsUseCaseProtocol {
    // MARK: Dependencies
    private let repository: ItemsRepositoryProtocol
    
    // MARK: Init
    init(repository: ItemsRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: Methods
    func execute() -> AsyncThrowingStream<[BinanceItem], Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let cachedItems = try await repository.getCachedItems()
                    continuation.yield(cachedItems)
                    print("cached items: \(cachedItems.count)")
                    let remoteItems = try await repository.refreshItems()
                    continuation.yield(remoteItems)
                    
                    print("remote items: \(remoteItems.count)")
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}
