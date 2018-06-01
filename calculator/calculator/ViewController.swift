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
        isOperatorClicked = !isOperatorClicked
        NSLog("\(self.isOperatorClicked)")
        if !(sender.tag == 17) {
            self.leftOperand = Double(display)
        } else {
            if isOperatorClicked && sender.tag == 17{
                if let operand = self.leftOperand, let rightOperand = Double(runningValue) {
                    let `operator` = Operator.init(rawValue: operatorValue)
                    if let result = `operator`?.operation(left: operand, right: rightOperand) {
                        NSLog("\(result)")
                    }
                }
                
            }
        }
        isOperatorClicked = true
    }
    @IBAction func equalButton(_ sender: CustomRoundButton) {
        
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

