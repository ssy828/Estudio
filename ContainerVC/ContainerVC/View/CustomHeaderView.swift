//
//  CustomHeaderView.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 20..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    // IBAction
    @IBAction func openCloseBtn(_ sender: UIButton) { }
    // IBOutlet
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var openCloseButton: UIButton!
    
    // Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
