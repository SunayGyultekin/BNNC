//
//  BNNCApp.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import SwiftUI

@main
struct BNNCApp: App {
    // MARK: Properties
    private let container = DIContainer()

    // MARK: Body
    var body: some Scene {
        WindowGroup {
            AppCoordinator(container: container)
        }
    }
}
