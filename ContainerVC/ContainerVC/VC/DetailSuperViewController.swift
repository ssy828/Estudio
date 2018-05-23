//
//  DetailSuperViewController.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 23..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class DetailSuperViewController: UIViewController {
    // MARK: Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: IBAction
    @IBAction func backToTodayVC(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
