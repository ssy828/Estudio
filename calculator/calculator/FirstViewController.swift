//
//  FirstViewController.swift
//  calculator
//
//  Created by SSY on 2018. 5. 27..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var displayLB: UILabel!
    
    @IBAction func showUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GoToCalculatorVC", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.displayLB.text = "100.000"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
