//
//  ItemsView.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import SwiftUI

struct ItemsView: View {
    // MARK: Properties
    @ObservedObject private var viewModel: ItemsVIewModel
    
    // MARK: Init
    init(viewModel: ItemsVIewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: Body
    var body: some View {
        content
            .navigationTitle("Items")
            .task {
                await viewModel.load()
            }
            .refreshable {
                await viewModel.refresh()
            }
    }
    
    @ViewBuilder
    
    private var content: some View {
        switch viewModel.viewState {
        case .idle:
            EmptyView()
        case .loading:
            ProgressView()
        case .empty:
            ContentUnavailableView("No Items",
                                   systemImage: "tray")
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let items):
            List(items) {
                ItemRowView(item: $0)
            }
        }
    }
}


struct ItemRowView: View {
    // MARK: Properties
    let item: BinanceItem
    
    // MARK: Body
    var body: some View {
        VStack {
            HStack {
                Text(item.symbol)
                Spacer()
                Text(item.priceChangePercent)
            }
            HStack {
                Text("bid/ask")
                Spacer()
                Text("\(item.bidPrice)/\(item.askPrice)")
            }
        }
    }
}
