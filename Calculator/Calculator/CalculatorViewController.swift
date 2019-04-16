//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Spencer Curtis on 3/6/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit
import RPN

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = userDefaults.string(forKey: "textFieldNumber") {
            textField.text = text
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()
    
    private var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                let numberString = numberFormatter.string(from: value as NSNumber)
                textField.text = numberString
                userDefaults.set(numberString, forKey: "textFieldNumber")
            } else {
                textField.text = ""
                userDefaults.removeObject(forKey: "textFieldNumber")
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                let numberString = numberFormatter.string(from: value as NSNumber)
                textField.text = numberString
                userDefaults.set(numberString, forKey: "textFieldNumber")
            } else {
                textField.text = ""
                userDefaults.removeObject(forKey: "textFieldNumber")
            }
        }
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        // Take the value from the accumulator and push it to the stack
        
        if let value = digitAccumulator.value() {
            calculator.push(number: value)
        }
        digitAccumulator.clear()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .subtract)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .add)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // If you want to do something when the text field gets cleared, you can do so now.
        calculator.clear()
        digitAccumulator.clear()
        return true
    }
    
    let userDefaults = UserDefaults(suiteName: "group.com.nateyoungren.Calculator")!
}
