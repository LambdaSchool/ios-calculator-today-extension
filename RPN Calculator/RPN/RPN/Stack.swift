//
//  Stack.swift
//  RPN
//
//  Created by Daniela Parra on 10/24/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

struct Stack<T>: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.items = elements
    }
    
    init(_ initialItems: [T] = [T]()) {
        self.items = initialItems
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
