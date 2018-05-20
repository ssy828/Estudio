//
//  CustomHeaderCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 20..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
