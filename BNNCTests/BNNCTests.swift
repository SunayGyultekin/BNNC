//
//  BNNCTests.swift
//  BNNCTests
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Testing
@testable import BNNC
import Foundation

@Suite("BNNC Test Suite")
struct BNNCTests {
    @Test("Sanity: test framework is wired up")
    func sanity() async throws {
        #expect(true)
    }
    
    // MARK: - Use Case Tests
    struct GetItemsUseCaseTests {
        /// Test use case success
        @Test
        func executeEmitsCachedThenRemoteItems() async throws {
            let repository = ItemsMockRepository(cachedItems: [.mockValue1],
                                                 remoteItems: [.mockValue1,
                                                               .mockValue2])
            let sut = await GetItemsUseCase(repository: repository)
            var received: [[BinanceItem]] = []
            for try await items in await sut.execute() {
                received.append(items)
            }
            
            #expect(repository.calls == [.cached, .remote])
            #expect(received.count == 2)
            #expect(received[0].count == 1)
            #expect(received[0][0].symbol == "LSKETH")
            #expect(received[1].count == 2)
            #expect(received[1][1].symbol == "QKCETH")
        }
        
        /// Test use case failure
        @Test
        func execute_whenRemoteSyncFails_emitsCachedItemsThenThrows() async {
            let repository = ItemsMockRepository(cachedItems: [.mockValue1],
                                                 remoteError: TestError.network)
            let sut = await GetItemsUseCase(repository: repository)
            var receivedItems: [[BinanceItem]] = []
            var receivedError: Error?
            
            do {
                for try await items in await sut.execute() {
                    receivedItems.append(items)
                }
            } catch {
                receivedError = error
            }
            
            #expect(repository.calls == [.cached, .remote])
            #expect(receivedItems.count == 1)
            #expect(receivedItems.first?.first?.symbol == "LSKETH")
            #expect(receivedError is TestError)
        }
    }
    
    // MARK: - ViewModel Tests
    @MainActor
    struct ItemsListViewModelTests {
        /// Test view model success
        @Test
        @MainActor
        func loadItems_displaysRemoteItems() async {
            let repository = ItemsMockRepository(cachedItems: [.mockValue1],
                                                 remoteItems: [.mockValue1,
                                                               .mockValue2])
            let sut = ItemsViewModel(getItemsUseCase: GetItemsUseCase(repository: repository))
            await sut.loadIfNeeded()
            await sut.loadingTask?.value
            
            #expect(repository.calls == [.cached, .remote])
            #expect(sut.items.count == 2)
            #expect(sut.items.last?.symbol == "QKCETH")
            #expect(sut.error == nil)
            #expect(!sut.isLoading)
        }
        
        /// Test local success, remote failure
        @Test
        @MainActor
        func loadItems_whenRemoteFails_keepsCachedItems() async {
            let repository = ItemsMockRepository(cachedItems: [.mockValue1],
                                                 remoteError: TestError.network)
            let sut = ItemsViewModel(getItemsUseCase: GetItemsUseCase(repository: repository))
            await sut.loadIfNeeded()
            await sut.loadingTask?.value
            
            #expect(repository.calls == [.cached, .remote])
            #expect(sut.items.count == 1)
            #expect(sut.items.first?.symbol == "LSKETH")
            #expect(sut.error?.localizedDescription == "Network unavailable")
            #expect(!sut.isLoading)
        }
        
        /// Test cached failire
        @Test
        @MainActor
        func loadItems_whenCacheFails_showsError() async {
            let repository = ItemsMockRepository(cachedError: TestError.database)
            let sut = ItemsViewModel(getItemsUseCase: GetItemsUseCase(repository: repository))
            await sut.loadIfNeeded()
            await sut.loadingTask?.value
            
            #expect(repository.calls == [.cached])
            #expect(sut.items.isEmpty)
            #expect(sut.error?.localizedDescription == "Database error")
            #expect(!sut.isLoading)
        }
    }
}
