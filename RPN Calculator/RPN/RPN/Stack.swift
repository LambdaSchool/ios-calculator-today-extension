//
//  Stack.swift
//  RPN
//
//  Created by De MicheliStefano on 19.09.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

// public: Can be used anywhere.
// internal: Can only be used within a project. Is set by default.
struct Stack<T>: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        items = elements
    }
    
    init(_ initialItems: [T] = [T]()) {
        items = initialItems
    }
    
    mutating func push(_ value: T) {
        items.append(value)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    
    func peek() -> T? {
        return items.last
    }
    
    private(set) var items: [T]
}
