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
    private var input: String?
    private var display = String()
    private var rightOperand: Double?
    private var leftOperand: Double?
    private var operatorValue: Operations?
    private var resultValue: String = ""
    private var isOperatorClicked: Bool = false // 연속으로 연산자 출력 못하기 위해서
    var dislplayValue: Double? {
        willSet {
            if let newDisplayValue = newValue {
                self.displayLB.text = String(newDisplayValue)
            }else{
                return self.displayLB.text = "0"
            }
        }
    }
    
    // MARK: Methods
    //    private func division(a: Int, to b:Int) -> Double {
    //        guard b != 0 else { return 0 }
    //        return Double(a / b)
    //    }
    
    //    private func didCalculate(using opertians: Operations) {
    //        switch opertians {
    //        case .addtion:
    //            self.convertToString(previousValue: previousValue, currentValue: currentValue, c: <#T##ViewController.Operations#>)
    //        default:
    //            break
    //        }
    //    }
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        if operatorValue != nil && input != nil {
            if let leftOperand = self.leftOperand, let rightOperand = self.rightOperand, let sign = self.operatorValue {
                if let result = sign.operation(right: rightOperand, left: leftOperand, sign: sign) {
                    switch sender.tag {
                    case 16:
                        self.displayLB.text = String(result)
                    case 15:
                        self.displayLB.text = String(result)
                    case 14:
                        self.displayLB.text = String(result)
                    case 13:
                        self.displayLB.text = String(result)
                    default:
                        break
                    }
                    isOperatorClicked = !isOperatorClicked
                }
            }
        }
        
    }
    
    
    @IBAction func doClickNumberButton(_ sender: CustomRoundButton){
        display += "\(sender.tag)"
        self.displayLB.text = display
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - enum
    enum Operations: String {
        case addtion = "+"
        case subtraction = "-"
        case multiplication = "*"
        case division = "/"
        
        func operation(right: Double, left: Double, sign: Operations) -> Double? {
            switch sign {
            case .addtion:
                return right + left
            case .subtraction:
                return right - left
            case .multiplication:
                return right * left
            case .division:
                return right / left
            }
        }
    }
    
    
}

