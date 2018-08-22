//
//  ContentTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 22..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var contentsTextField: UITextField!
    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentsTextField.becomeFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
