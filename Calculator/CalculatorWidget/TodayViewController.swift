//
//  TodayViewController.swift
//  CalculatorWidget
//
//  Created by Linh Bouniol on 10/22/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit
import NotificationCenter
import RPN

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - Properties
    
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
    
    // accumulate 1, 2, 3 into one number: 123
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    let groupUserDefaults = UserDefaults(suiteName: "group.linhbouniol.Calculator")!
    
    // MARK: - Outlets/Actions
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var operatorButtons: [UIButton]! // outlet collection: the four +/-/x/÷ buttons
    
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
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .add)
    }
    
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .subtract)
    }
    
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .multiply)
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        returnButtonTapped(sender)
        calculator.push(operator: .divide)
    }
    
    @IBAction func copyButtonTapped(_ sender: UIButton) {
        UIPasteboard.general.string = textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        number1Button.layer.borderWidth = 1
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        DispatchQueue.main.async {
            
            if let colorData = self.groupUserDefaults.value(forKey: "ThemeColor") as? Data, let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                
                for button in self.operatorButtons {
                    button.backgroundColor = color
                }
            }
            
            
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Methods
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculator.clear()
        digitAccumulator.clear()
        return true
    }  
}
