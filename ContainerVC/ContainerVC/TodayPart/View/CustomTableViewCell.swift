//
//  CustomTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 18..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLb: UILabel! // 내용
    @IBOutlet weak var moneyLb: UILabel! // 금액 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
