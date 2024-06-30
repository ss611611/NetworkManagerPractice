//
//  URL+.swift
//  NetworkManagerPractice
//
//  Created by Jackie Lu on 2024/6/27.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        self.init(string: value.description)!
    }
}
