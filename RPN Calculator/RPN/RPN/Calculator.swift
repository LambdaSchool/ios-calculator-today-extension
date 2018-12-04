//
//  Calculator.swift
//  Calculator
//
//  Created by Daniela Parra on 10/24/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

public struct Calculator {
    
    public init() {}
    
    public enum Operator {
        case add, subtract, multiply, divide
    }
    
    public mutating func push(number: Double) {
        stack.push(number)
    }
    
    public mutating func push(operator: Operator) {
        let a = stack.pop() ?? 0.0
        let b = stack.pop() ?? 0.0
        let result: Double
        
        switch `operator` {
        case .add:
            result = a + b
        case .subtract:
            result = a - b
        case .multiply:
            result = a * b
        case .divide:
            result = a / b
        }
        
        //Push result back to stack
        stack.push(result)
    }
    
    public mutating func clear() {
        stack = [0.0, 0.0]
    }
    
    public var topValue: Double? {
        return stack.peek()
    }
    
    private var stack: Stack<Double> = [0.0, 0.0]
}
