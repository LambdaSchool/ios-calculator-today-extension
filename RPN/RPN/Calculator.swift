//
//  Calculator.swift
//  RPN
//
//  Created by Linh Bouniol on 9/19/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

// public so RPN can access it
public struct Calculator {
    
    // the calculator doesn't know anything about the UI, so when the user taps the add button, we need a way to let the calculator know
    // Calculator should have access to its methods/properties, so why make it public?
    public enum Operator {
        case add, subtract, multiply, divide
    }
    
    // struct creates an init() for free, but by default its internal so we need to make it public for others to see
    public init() {}
    
    private var stack: Stack<Double> = [0.0, 0.0]
    
    public var topValue: Double? {
        return stack.peek() // this allows us to see the value
    }
    
    // need methods to do stuff
    
    // mutating b/c its going to modify the stack
    public mutating func push(number: Double) {
        stack.push(number)
    }
    
    public mutating func push(operator: Operator) {
        
        // if the stack is empty, then want it to be 0.0
        let operand2 = stack.pop() ?? 0.0   // when we turn on a calculator, its always starts w/ 0.0
        let operand1 = stack.pop() ?? 0.0
        
        let result: Double
        
        switch `operator` { // ` ` will tell the system that this is our variable operation, not the system operator. sometimes the name are the same
        case .add:
            result = operand1 + operand2
        case .subtract:
            result = operand1 - operand2
        case .multiply:
            result = operand1 * operand2
        case .divide:
            result = operand1 / operand2
        }
        
        stack.push(result)
    }
    
    public mutating func clear() {
//        stack = [0.0, 0.0]
    }
}
