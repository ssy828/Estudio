//
//  CustomCollectionViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 5..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var buttonTitle: String?
    private var buttonColor: UIColor?
    // MARK: IBOutlet
    @IBOutlet weak var colorButton: UIButton!
    // MARK: IBAction
    @IBAction func didClickColor(_ sender: UIButton) {
       self.buttonColor = sender.backgroundColor
       self.buttonTitle = sender.titleLabel?.text
        print("\(String(describing: self.buttonTitle)),\(String(describing: self.buttonColor))")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
