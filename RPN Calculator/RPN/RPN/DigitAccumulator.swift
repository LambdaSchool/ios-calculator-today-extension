//
//  DigitAccumulator.swift
//  Calculator
//
//  Created by Daniela Parra on 10/24/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case extraDecimalPoint
    case invalidDigitNumberValue
}

public struct DigitAccumulator {
    
    public init() { }
    
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    public mutating func add(digit: Digit) throws {
        // Add the digit to the digits array below or if it is invalid, ignore it
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        case .number(let value):
            if value < 0 || value > 9 {
                throw DigitAccumulatorError.invalidDigitNumberValue
            }
        }
        
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits = []
    }
    // [1,2,.,4,5] -> [12.45]
    public func value() -> Double? {
        let result = digits.map { (digit) -> String in
            switch digit {
            case .decimalPoint:
                return "."
            case .number(let num):
                return String(num)
            }
        }.joined()
        return Double(result)
    }
    
    private var digits: [Digit] = []
}
