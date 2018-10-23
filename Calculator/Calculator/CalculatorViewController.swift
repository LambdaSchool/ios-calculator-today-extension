//
//  CalculatorViewController.swift
//  Calculator
//

import UIKit
import RPN

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    
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
	
	@IBOutlet var textField: UITextField!
	
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
    
    @IBAction func changeThemeColor(_ sender: UIButton) {
        view.tintColor = sender.tintColor
        
        if let colorData = try? NSKeyedArchiver.archivedData(withRootObject: sender.tintColor, requiringSecureCoding: true) {
            groupUserDefaults.set(colorData, forKey: "ThemeColor")
        }
    }
    
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		calculator.clear()
		digitAccumulator.clear()
		return true
	}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let colorData = groupUserDefaults.value(forKey: "ThemeColor") as? Data, let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
            view.tintColor = color
        }
    }
}
