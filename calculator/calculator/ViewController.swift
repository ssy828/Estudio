//
//  ViewController.swift
//  calculator
//
//  Created by SSY on 2018. 5. 26..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: enum
    enum Operator: String {
        case addtion = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "/"
        
        func operation(left: Double, right: Double) -> Double? {
            switch self {
            case .addtion: return left + right
            case .subtraction : return left - right
            case .multiplication: return left * right
            case .division: return left / right
            }
        }
        
    }
    
    // MARK: Properties
    private var display = String()
    private var leftOperand: Double?
    private var operatorValue: String?
    private var operatorInstance: Operator?
    private var isOperatorClicked: Bool = false // 연속으로 연산자 출력 못하기 위해서

    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        self.operatorValue = sender.titleLabel?.text
        isOperatorClicked = !isOperatorClicked
        if let sign = operatorValue, let leftOperand = Double(display), let rightOperand = Double(display) {
            let test = Operator.init(rawValue: sign)
            if let result = test?.operation(left: leftOperand, right: rightOperand){
                NSLog("\(result)")
            }
            
        }
//        isOperatorClicked = true
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

