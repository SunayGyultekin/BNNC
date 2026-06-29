//
//  ItemsVIewModel.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation
internal import Combine

@MainActor
final class ItemsVIewModel: ObservableObject {
    @Published var state: ViewState<[BinanceItem]> = .idle
    private let getItemsUseCase: GetItemsUseCaseProtocol
    private var loadTask: Task<Void, Never>?
    private var hasReceivedFirstValue = false
    
    // MARK: Init and Deinit
    init(getItemsUseCase: GetItemsUseCaseProtocol) {
        self.getItemsUseCase = getItemsUseCase
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    // MARK: Methods
    func loadIfNeeded(forceLoad: Bool = false) async {
        guard forceLoad || { if case .idle = state { return true } else { return false } }() else { return }
        
        loadTask?.cancel()

        loadTask = Task<Void, Never> {
            if !hasReceivedFirstValue {
                state = .loading
            }
            do {
                let stream = await getItemsUseCase.execute()
                for try await items in stream {
                    state = .loaded(items)
                    hasReceivedFirstValue = true
                }
            } catch is CancellationError {
                // Ignore cancellation
            } catch {
                state = .failed(error)
            }
        }
    }

    func refresh() async {
        await loadIfNeeded(forceLoad: true)
    }
}
