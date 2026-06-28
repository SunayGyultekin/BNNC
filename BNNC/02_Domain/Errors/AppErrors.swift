//
//  AppErrors.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 26.06.26.
//

import Foundation

enum AppError: Error {
    case network
    case decoding
    case database
    case unknown
    case custom(String)
}
