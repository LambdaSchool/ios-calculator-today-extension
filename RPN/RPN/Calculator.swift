//
//  Calculator.swift
//  RPN
//
//  Created by Nathanael Youngren on 3/13/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

public struct Calculator {
    
    public enum Operator {
        case add
        case subtract
        case multiply
        case divide
    }
    
    public init() { }
    
    public mutating func push(number: Double) {
        stack.push(number)
    }
    
    public mutating func push(operator: Operator) {
        let operand2 = stack.pop() ?? 0.0
        let operand1 = stack.pop() ?? 0.0
        
        var result: Double = 0.0
        
        // you can use keywords as variable names, but you have to use backticks
        switch `operator` {
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
        stack = [0.0, 0.0]
    }
    
    public var topValue: Double? {
        return stack.peek()
    }
    
    var stack: Stack<Double> = [0.0, 0.0]
}
