//
//  DigitAccumulator.swift
//  RPN
//
//  Created by De MicheliStefano on 19.09.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
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
    
    public init() {}
    
    public mutating func add(digit: Digit) throws {
        switch digit {
        case .decimalPoint:
            if digits.contains(.decimalPoint) {
                throw DigitAccumulatorError.extraDecimalPoint
            }
        case .number(let value):
            if value < 0 || 9 < value {
                throw DigitAccumulatorError.invalidDigitNumberValue
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
                case let .number(x): return String(x)
                case .decimalPoint: return "."
            }
        }.joined()
        
        return Double(string)
    }
    
    private var digits = [Digit]()
    
}
