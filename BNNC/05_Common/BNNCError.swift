//
//  BNNCError.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

enum BNNCError: LocalizedError {
    case unsupportedAction
    
    // MARK: Error message
    var localizedMessage: String {
        switch self {
        case .unsupportedAction:
            return "Unsupported action"
        }
    }
}
