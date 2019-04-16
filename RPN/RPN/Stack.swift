//
//  Stack.swift
//  RPN
//
//  Created by Nathanael Youngren on 3/13/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Stack<Element>: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = Element
    
    init(arrayLiteral elements: Element...) {
        items = elements
    }
    
    init(_ elements: [Element] = []) {
        self.items = elements
    }
    
    mutating func push(_ value: Element) {
        items.append(value)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
    
    func peek() -> Element? {
        return items.last
    }

    private var items: [Element]
}
