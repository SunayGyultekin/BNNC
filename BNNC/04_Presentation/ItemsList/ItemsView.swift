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
        NavigationStack {
            content
                .navigationTitle("Items")
                .task {
                    await viewModel.loadIfNeeded()
                }
                .refreshable {
                    await viewModel.refresh()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .controlSize(.large)
        case .empty:
            ContentUnavailableView("No Items",
                                   systemImage: "tray")
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let items):
            ScrollViewReader { proxy in
                List(items, id: \.self) { item in
                    NavigationLink(value: item) {
                        ItemRowView(item: item)
                    }
                }
                .navigationDestination(for: BinanceItem.self) { selectedItem in
                    ItemDetailsView(item: selectedItem)
                }
            }
            
        }
    }
    
    let backgroundGradient = LinearGradient(colors: [Color.gray, Color.white],
                                            startPoint: .top,
                                            endPoint: .bottom)
}


struct ItemRowView: View {
    // MARK: Properties
    let item: BinanceItem
    
    // MARK: Body
    var body: some View {
        VStack {
            HStack {
                Text(item.symbol)
                    .font(.headline)
                Spacer()
                Text(item.priceChangePercent.toFormattedPercent() ?? "")
                    .font(.headline)
                    .foregroundStyle(item.percentageColor)
            }
            HStack {
                Text("bid/ask:")
                    .font(.subheadline)
                Spacer()
                Text("\(item.bidPrice)/\(item.askPrice)")
                    .font(.subheadline)
            }
        }
    }
}
