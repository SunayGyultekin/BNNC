//
//  ItemDetailsView.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import SwiftUI

struct ItemDetailsView: View {
    // MARK: Properties
    @State var item: BinanceItem
    
    // MARK: Body
    var body: some View {
        List(item.properties.sorted { $0.index < $1.index }, id: \.self) { property in
            VStack {
                HStack{
                    Text(property.keyName)
                        .font(.caption)
                    Spacer()
                }
                HStack{
                    Text(property.value)
                        .font(.headline)
                    Spacer()
                }
            }
        }
        .navigationTitle("Item Details")
    }
}
