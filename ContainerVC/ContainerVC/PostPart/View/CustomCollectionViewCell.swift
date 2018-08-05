//
//  CustomCollectionViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 5..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: IBOutlet
    @IBOutlet weak var colorButton: UIButton!
    // MARK: IBAction
    @IBAction func didClickColor(_ sender: UIButton) {
        print("Clicked!!!")
    }
}
