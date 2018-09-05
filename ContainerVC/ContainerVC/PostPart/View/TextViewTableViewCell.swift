//
//  TextViewTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 27..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var memoTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
