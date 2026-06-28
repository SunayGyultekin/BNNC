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
    @Published var viewState: ViewState<[BinanceItem]> = .empty
    private let getItemsUseCase: GetItemsUseCaseProtocol
    private var loadTask: Task<Void, Never>?
    
    // MARK: Init and Deinit
    init(getItemsUseCase: GetItemsUseCaseProtocol) {
        self.getItemsUseCase = getItemsUseCase
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    // MARK: Methods
    func load() async {
        loadTask?.cancel()

        loadTask = Task<Void, Never> {
            viewState = .loading
            
            do {
                var hasReceivedFirstValue = false
                let stream = await getItemsUseCase.execute()
                for try await items in stream {
                    self.viewState = .loaded(items)
                    // Stop showing the loading indicator as soon as
                    // the first value (typically the cache) arrives.
                    if !hasReceivedFirstValue {
                        self.viewState = .loaded(items)
                        hasReceivedFirstValue = true
                    }
                }
            } catch is CancellationError {
                // Ignore cancellation
            } catch {
                self.viewState = .failed(error)
            }
        }
    }

    func refresh() async {
        await load()
    }
}
