//
//  Int64+Extension.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 29.06.26.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000.0)
    }
}

