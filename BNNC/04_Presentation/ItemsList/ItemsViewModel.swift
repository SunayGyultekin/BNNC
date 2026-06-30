//
//  ItemsViewModel.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation
internal import Combine

@MainActor
final class ItemsViewModel: ObservableObject {
    @Published var items: [BinanceItem] = []
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var error: Error? = nil
    
    private let getItemsUseCase: GetItemsUseCaseProtocol
    private(set) var loadingTask: Task<Void, Never>?
    private var hasReceivedFirstValue = false
    
    // MARK: Init and Deinit
    init(getItemsUseCase: GetItemsUseCaseProtocol) {
        self.getItemsUseCase = getItemsUseCase
    }
    
    deinit {
        loadingTask?.cancel()
    }
    
    // MARK: Methods
    func loadIfNeeded(forceLoad: Bool = false) async {
        guard forceLoad || items.isEmpty else { return }
        loadingTask?.cancel()

        loadingTask = Task<Void, Never> {
            if !hasReceivedFirstValue {
                isLoading = true
            }
            do {
                for try await loadedItems in getItemsUseCase.execute() {
                    isLoading = false
                    print("Loaded items count: \(loadedItems.count)")
                    items = loadedItems
                    hasReceivedFirstValue = true
                }
            } catch is CancellationError {
                isLoading = false
                // Ignore cancellation
            } catch (let err) {
                isLoading = false
                showError = true
                error = err
            }
        }
    }

    func refresh() async {
        await loadIfNeeded(forceLoad: true)
    }
}
