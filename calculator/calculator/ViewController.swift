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
    private var resultValue: String?
    private var isOperatorClicked: Bool = false // 연속으로 연산자 출력 못하기 위해서
    private var runningValue : String {
        return !(display.isEmpty) ? display : "0"
    }
    //    private var runningValue = String()
    
    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        guard let operatorValue = sender.titleLabel?.text else { return }
        isOperatorClicked = !isOperatorClicked // 현재 연산 버튼 상태 넣어줌
        NSLog("\(!isOperatorClicked)")
        if leftOperand == nil {
            self.leftOperand = Double(display)
        } else {
            if isOperatorClicked {
                guard let operand = self.leftOperand, let rightOperand = Double(runningValue) else { return }
                let `operator` = Operator.init(rawValue: operatorValue)
                guard let result = `operator`?.operation(left: operand, right: rightOperand) else { return }
                NSLog("\(result)")
                resultValue = "\(result)"
                isOperatorClicked = true
            }
        }
        
    }
    @IBAction func equalButton(_ sender: CustomRoundButton) {
        if isOperatorClicked {
            self.displayLB.text = display
        } else {
            if let result = self.resultValue {
                self.displayLB.text = result
            }
        }

    }
    
    @IBAction func doClickNumberButton(_ sender: CustomRoundButton){
        guard let input = sender.titleLabel?.text else { return }
        if isOperatorClicked { // Save value when Operator button pressed
            // single digit
            display = input
            NSLog(runningValue)
            isOperatorClicked = false
        } else {
            // multiple digits
            display += input
        }
        NSLog(display)
        self.displayLB.text = display
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - enum
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
}

