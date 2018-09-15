//
//  ContentTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 22..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    // MARK: propeties
    internal var didAddHandler: ((String?) -> Void)?
    // MARK: IBOutlet
    @IBOutlet weak var contentsTextField: UITextField!
    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentsTextField.becomeFirstResponder()
    }
    @IBAction func didChange(_ sender: UITextField) {
        // 텍스트필드를 넘기는 법 -> 이렇게 해도 되나?
        self.didAddHandler?(sender.text)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
