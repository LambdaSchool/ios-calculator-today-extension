//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Linh Bouniol on 9/19/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

// not direct connection with calculator

public enum DigitAccumulatorError: Error {
    case extraDecimalPoint
    case invalidDigitNumberValue
}

public struct DigitAccumulator {
    
    private var digits = [Digit]()
    
    public init() {}
    
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int) // number must be one digit of number
    }
    
    public mutating func add(digit: Digit) throws { // wants to throw errors when something is wrong
        
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            } // when throw it will return out of the func
            
            // add decimal to the accumulator
//            digits.append(digit)
        case .number(let value):
            // add the value to the accumulator
            if value < 0 || 9 < value {
                throw DigitAccumulatorError.invalidDigitNumberValue
            }
//            digits.append(digit)
        }
        
        digits.append(digit)
    }
    
    public mutating func clear() {
        digits.removeAll()
    }
    
    // not mutating b/c it doesn't modify [Digit]
    public func value() -> Double? { // optional b/c might not have any digits
        // get all of the digits from `digits` and turn them into a single Double
        // if digits [1, 2, 3, .decimalPoint, 4, 5, 6] then return 123.456
        
        var result = 0.0
        var encounteredDecimal = false
        var decimalPosition = 1
        
        for digit in digits {
            
            switch digit {
            case .decimalPoint:
                // decimal point
                encounteredDecimal = true
            case .number(let intValue):
                // intValue is the number
                if encounteredDecimal == false {
                    result = result * 10 + Double(intValue)
                } else {
                    decimalPosition *= 10
                    result += Double(intValue) / Double(decimalPosition) // 4 / 10, then add 123
                }
            }
        }
        
        return result
    }
}
