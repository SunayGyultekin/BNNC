//
//  ItemsView.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import SwiftUI

struct ItemsView: View {
    // MARK: Properties
    @ObservedObject private var viewModel: ItemsViewModel
    
    // MARK: Init
    init(viewModel: ItemsViewModel) {
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
                .overlay(loadingOverlay)
                .alert("ERROR", isPresented: $viewModel.showError) {
                    Button("OK", role: .cancel) { viewModel.showError = false }
                } message: {
                    Text(viewModel.error?.localizedDescription ?? "")
                }
        }
    }
    
    private var itemsList: some View {
        ScrollViewReader { proxy in
            List(viewModel.items, id: \.self) { item in
                NavigationLink(value: item) {
                    ItemRowView(item: item)
                }
            }
            .navigationDestination(for: BinanceItem.self) { selectedItem in
                ItemDetailsView(item: selectedItem)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.items.isEmpty {
            ContentUnavailableView("No Items",
                                   systemImage: "tray")
        } else {
            itemsList
        }
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ProgressView()
                .controlSize(.large)
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
