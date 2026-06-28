//
//  ViewState.swift
//  BNNC
//
//  Created by Sunay Gyultekin on 27.06.26.
//

enum ViewState<T> {
    case idle
    case loading
    case loaded(T)
    case empty
    case failed(Error)
}
