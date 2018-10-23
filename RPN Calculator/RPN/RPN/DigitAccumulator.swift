//
//  DigitAccumulator.swift
//  RPN
//
//  Created by Andrew Lao on 9/19/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

public enum DigitAccumulatorError: Error {
    case extraDecimalPoint
    case invalidDigitNumberValue
}

public struct DigitAccumulator {
    public enum Digit: Equatable {
        case decimalPoint
        case number(Int)
    }
    
    
    public init(){
        
    }
    
    public mutating func add(digit: Digit) throws {
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
    
    public mutating func clear(){
        digits.removeAll()
    }
    
//    public func value() -> Double? {
//        var stringRepresentation = ""
//        for digit in digits{
//            switch digit {
//            case .decimalPoint:
//                stringRepresentation.append(".")
//            case .number(let value):
//                stringRepresentation.append(String(value))
//            }
//        }
//        return Double(stringRepresentation)
//    }
    
    public func value() -> Double? {
        let string = digits.map { (digit) -> String in
            switch digit {
            case let .number(x): return String(x)
            case .decimalPoint: return "."
            }
            }.joined()
        
        return Double(string)
    }

    
    private var digits = [Digit]()
}
