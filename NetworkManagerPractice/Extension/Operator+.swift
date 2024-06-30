//
//  Operator+.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import Foundation

func ==<T, Value: Equatable>(keyPath: KeyPath<T, Value>, value: Value) -> (T) -> Bool {
    { $0[keyPath: keyPath] == value }
}
