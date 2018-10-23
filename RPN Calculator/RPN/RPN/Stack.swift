//
//  Stack.swift
//  RPN
//
//  Created by Andrew Liao on 9/19/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

//by default use the most restrictive access level. open up as necessary
struct Stack<T>: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        items = elements
    }
    init(_ initialItems: [T] = [T]()){
        items = initialItems
    }
    
    mutating func push(_ value: T){
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
