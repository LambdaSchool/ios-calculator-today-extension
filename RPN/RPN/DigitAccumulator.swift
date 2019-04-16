//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Nathanael Youngren on 3/13/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case invalidNumberValue
    case extraDecimalPoint
}

public struct DigitAccumulator {
    
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    public init() { }
    
    public mutating func add(digit: Digit) throws {
        
        switch digit {
        case .number(let value):
            if value < 0 || value > 9 {
                throw DigitAccumulatorError.invalidNumberValue
            }
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        }
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    public func value() -> Double? {
        
        let string = digits.map { (digit) -> String in
            switch digit {
            case .decimalPoint:
                return "."
            case .number(let value):
                return String(value)
            }
        }.joined()
        
        return Double(string)
    }
    
    private var digits: [Digit] = []
}
