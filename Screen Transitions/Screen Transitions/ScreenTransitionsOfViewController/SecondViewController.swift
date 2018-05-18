//
//  SecondViewController.swift
//  Screen Transitions
//
//  Created by SSY on 2018. 5. 11..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController {

    @IBAction func previousVC(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
