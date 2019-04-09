//
//  Stack.swift
//  RPN
//
//  Created by Moses Robinson on 4/8/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import Foundation

import Foundation

struct Stack<Element>: ExpressibleByArrayLiteral {
    
    typealias ArrayLiteralElement = Element
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.elements = elements
    }
    
    // Add things to the stack
    mutating func push(_ element: Element) {
        elements.append(element)
    }
    
    // Remove them from the stack
    mutating func pop() -> Element? {
        return elements.popLast()
    }
    
    // Know what is at the top of the stack
    func peek() -> Element? {
        return elements.last
    }
    
    
    // private(set) allows other types to read the value of elements, but not write to it, unless using methods in Stack.
    private(set) var elements: [Element]
}
