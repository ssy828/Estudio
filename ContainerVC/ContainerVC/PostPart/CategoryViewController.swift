//
//  CategoryViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 12..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    // MARK: Properties
    
    // MARK: IBOutlet
    
    // MARK: IBAction
    @IBAction func didTapColorButton(_ sender: UIButton) {
        sender.setImage(#imageLiteral(resourceName: "icons8-checkmark-24"), for: UIControlState.normal)
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
