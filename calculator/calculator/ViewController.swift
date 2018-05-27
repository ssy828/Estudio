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
    private var currentNumber: String = ""
    private var currentValue: Double = 0
    private var previousValue: Double = 0
    private var resultValue: Double = 0
    private var isClicked: Bool = false
    var displayNumber: Double? {
        willSet {
            if let newDisplayValue = newValue {
                self.displayLB.text = String(newDisplayValue)
            }else{
                return self.displayLB.text = "0"
            }
        }
    }
    
    // MARK: Methods
    private func division(a: Int, to b:Int) -> Double {
        guard b != 0 else { return 0 }
        return Double(a / b)
    }
    
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var displayLB: UILabel!
    
    // MARK: - IBAction
    @IBAction func operatorButton(_ sender: CustomRoundButton) {
        switch sender.tag {
        case 16:
            self.displayLB.text = Operations.addtion.rawValue
        case 15:
            self.displayLB.text = Operations.subtraction.rawValue
        case 14:
            self.displayLB.text = Operations.division.rawValue
        case 13:
            self.displayLB.text = Operations.multipication.rawValue
        default:
            break
        }
        isClicked = !isClicked
        NSLog("!isClicked")
    }
    @IBAction func doClickNumberButton(_ sender: CustomRoundButton){
        currentNumber += "\(sender.tag)"
        self.displayLB.text = currentNumber
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
        case multipication = "x"
        case division = "/"
    }
    
    
}

