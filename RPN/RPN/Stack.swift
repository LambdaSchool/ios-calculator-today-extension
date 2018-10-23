//
//  Stack.swift
//  RPN
//
//  Created by Linh Bouniol on 9/19/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

/*
 By default, the struct or class is internal, meaning it can be used only in this file
 Should this struct be public? -Only if we want to expose this file to other module.
 By default, it should be internal until we need to make it public.
 */

struct Stack<T>: ExpressibleByArrayLiteral {
    
    private(set) var items: [T]
    
    typealias ArrayLiteralElement = T
    
    init(arrayLiteral elements: ArrayLiteralElement...) { // ... means its a list of things
        items = elements
    }
    
    init(_ initialItems: [T] = [T]()) {
        items = initialItems
    }
    
    mutating func push(_ value: T) {
        items.append(value)
    }
    
    mutating func pop() -> T? { // optional b/c the array might be empty
        return items.popLast()
    }
    
    func peek() -> T? { // look at the last item, without doing anything
        return items.last
    }
}
