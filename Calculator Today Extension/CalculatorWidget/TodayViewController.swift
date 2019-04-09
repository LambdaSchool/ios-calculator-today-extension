//
//  TodayViewController.swift
//  CalculatorWidget
//
//  Created by Moses Robinson on 4/8/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit
import NotificationCenter
import RPN

class TodayViewController: UIViewController, NCWidgetProviding, UITextFieldDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        

        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        switch activeDisplayMode {
            
        case .compact:
            
            preferredContentSize = maxSize
            self.copyButton.isHidden = false
            self.stack1.isHidden = true
            self.stack2.isHidden = true
            self.stack3.isHidden = true
            self.stack4.isHidden = true
        case.expanded:
        
            preferredContentSize = CGSize(width: maxSize.width, height: 400)
            self.copyButton.isHidden = true
            self.stack1.isHidden = false
            self.stack2.isHidden = false
            self.stack3.isHidden = false
            self.stack4.isHidden = false
        default:
            break
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
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = textField.text
        textField.text = ""
    }
    
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        
        // Take the vakue from the accumulator and push it to the stack
        
        if let value = digitAccumulator.value() {
            calculator.push(value)
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
        // If you want do something when the text field gets cleared, you can do so now.
        
        calculator.clearStack()
        digitAccumulator.clear()
        return true
    }
    
    // MARK: -- Properties
    
    @IBOutlet var copyButton: UIButton!
    @IBOutlet var stack1: UIStackView!
    @IBOutlet var stack2: UIStackView!
    @IBOutlet var stack3: UIStackView!
    @IBOutlet var stack4: UIStackView!
    
}
