//
//  ViewController.swift
//  calculator
//
//  Created by SSY on 2018. 5. 26..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private var display = String()
    private var leftOperand: Double?
    private var operatorValue: String?
    private var isOperatorClicked: Bool = false // 연속으로 연산자 출력 못하기 위해서
    
    // MARK: Methods
    private func operation(left: Double, right: Double, sign: String
        ) -> Double? {
        switch sign {
        case "+": return left + right
        case "-": return left - right
        case "*": return left * right
        case "/": return left / right
        default: break
        }
        return nil
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        isOperatorClicked = !isOperatorClicked
        self.operatorValue = sender.titleLabel?.text
        if operatorValue == nil {
            self.leftOperand = Double(display)
        } else {
            if let leftOperand = self.leftOperand,
                let rightOperand = Double(display),
                let sign = self.operatorValue {
                if let result = operation(left: leftOperand,
                                          right: rightOperand,
                                          sign: sign) {
                    NSLog("\(result)")
                    
                }
            }
        }
        
    }
    
    @IBAction func equalButton(_ sender: CustomRoundButton) {
        
    }
    
    @IBAction func doClickNumberButton(_ sender: CustomRoundButton){
        if let input = sender.titleLabel?.text {
            if isOperatorClicked {
                // single digit
                display = input
                isOperatorClicked = false
            }else {
                // multiple digits
                display += input
            }
        }
        self.displayLB.text = display
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

