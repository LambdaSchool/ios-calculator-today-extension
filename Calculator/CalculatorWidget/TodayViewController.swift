//
//  TodayViewController.swift
//  CalculatorWidget
//
//  Created by Nathanael Youngren on 4/16/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit
import NotificationCenter
import RPN

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = userDefaults.string(forKey: "textFieldNumber") {
            calculatorTextField.text = text
        }
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
            rpnCalculatorLabel.isHidden = false
            calculatorTextField.isHidden = true
            rowOneStack.isHidden = true
            rowTwoStack.isHidden = true
            rowThreeStack.isHidden = true
            rowFourStack.isHidden = true
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 400)
            rpnCalculatorLabel.isHidden = true
            calculatorTextField.isHidden = false
            rowOneStack.isHidden = false
            rowTwoStack.isHidden = false
            rowThreeStack.isHidden = false
            rowFourStack.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func copyNumberButtonTapped(_ sender: UIButton) {
        guard let number = calculatorTextField.text else { return }
        let pasteboard = UIPasteboard.general
        pasteboard.string = number
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        if let value = digitAccumulator.value() {
            calculator.push(number: value)
        }
        digitAccumulator.clear()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .divide)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .multiply)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .subtract)
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .add)
    }
    
    private var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                let numberString = numberFormatter.string(from: value as NSNumber)
                calculatorTextField.text = numberString
                userDefaults.set(numberString, forKey: "textFieldNumber")
                
            } else {
                calculatorTextField.text = ""
                userDefaults.removeObject(forKey: "textFieldNumber")
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                let numberString = numberFormatter.string(from: value as NSNumber)
                calculatorTextField.text = numberString
                userDefaults.set(numberString, forKey: "textFieldNumber")
            } else {
                calculatorTextField.text = ""
                userDefaults.removeObject(forKey: "textFieldNumber")
            }
        }
    }
    
    let userDefaults = UserDefaults(suiteName: "group.com.nateyoungren.Calculator")!
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()
    
    @IBOutlet weak var rpnCalculatorLabel: UILabel!
    @IBOutlet weak var calculatorTextField: UITextField!
    @IBOutlet weak var rowOneStack: UIStackView!
    @IBOutlet weak var rowTwoStack: UIStackView!
    @IBOutlet weak var rowThreeStack: UIStackView!
    @IBOutlet weak var rowFourStack: UIStackView!
}
