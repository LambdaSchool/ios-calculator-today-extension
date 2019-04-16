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
    
    @IBOutlet weak var rpnCalculatorLabel: UILabel!
    @IBOutlet weak var calculatorTextField: UITextField!
    @IBOutlet weak var rowOneStack: UIStackView!
    @IBOutlet weak var rowTwoStack: UIStackView!
    @IBOutlet weak var rowThreeStack: UIStackView!
    @IBOutlet weak var rowFourStack: UIStackView!
}
