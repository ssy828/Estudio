//
//  ContentTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 22..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
// MARK: - protocol ContentTableViewCellDelegate
protocol ContentTableViewCellDelegate: class {
    func pass(contentTitle: String?)
}

class ContentTableViewCell: UITableViewCell {
    // MARK: propeties
//    internal var didAddHandler: ((String?) -> Void)?
    weak var delegate: ContentTableViewCellDelegate?
    // MARK: IBOutlet
    @IBOutlet weak var contentsTextField: UITextField!
    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentsTextField.becomeFirstResponder()
        self.contentsTextField.delegate = self
    }
//    @IBAction func didChange(_ sender: UITextField) {
//        // 텍스트필드를 넘기는 법 -> 이렇게 해도 되나?
//        self.didAddHandler?(sender.text)
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
// MARK: - UITextFieldDelegate
extension ContentTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.pass(contentTitle: self.contentsTextField.text)
    }
}
