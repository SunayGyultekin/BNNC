//
//  AppCoordinator.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import SwiftUI

struct AppCoordinator: View {
    // MARK: Properties
    let container: DIContainer
    
    // MARK: Body
    var body: some View {
        ItemsView(viewModel: container.makeItemsViewModel())
    }
}
