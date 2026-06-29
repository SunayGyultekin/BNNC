//
//  String+Extensions.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 29.06.26.
//

import Foundation
import SwiftUI

extension String {
    func toFormattedPercent() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        guard let doubleValue = Double(self) else { return nil }
        return formatter.string(from: NSNumber(floatLiteral: doubleValue/100))
    }
    
    func getChangeColor() -> Color {
        if self.contains("-") {
            return .red
        } else if let doubleValue = Double(self), doubleValue == 0 {
            return .black
        } else {
            return .green
        }
    }
}
