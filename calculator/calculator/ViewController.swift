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
    private var operatorValue: String? = nil
    private var isOperatorClicked: Bool = false // 연속으로 연산자 출력 못하기 위해서
    
    // MARK: Methods
    private func operation(left: Double, right: Double, sign: String
        ) -> Double? {
        switch sign {
        case "+": return left + right
        case "-": return left - right
        case "*": return left * right
        case "/": return left / right
        default:  break
        }
        return nil
    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        guard let sign = sender.titleLabel?.text,
              let leftOperand = self.leftOperand else { return }
        isOperatorClicked = !isOperatorClicked
        if isOperatorClicked {
            if let rightOperand = Double(display) {
                if let result = self.operation(left: leftOperand,
                                               right: rightOperand,
                                               sign: sign) {
                    switch sign {
                    case "+": self.displayLB.text = String(result)
                    case "*": self.displayLB.text = String(result)
                    case "-": self.displayLB.text = String(result)
                    case "/": self.displayLB.text = String(result)
                    case "=": self.displayLB.text = String(result)
                    default:
                        break
                    }
                }
            }
        }
        
    }
    
    @IBAction func doClickNumberButton(_ sender: CustomRoundButton){
        if let input = sender.titleLabel?.text {
            if isOperatorClicked {
                display = input
                isOperatorClicked = false // 1자리수만 더할 경우
            }else {
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

