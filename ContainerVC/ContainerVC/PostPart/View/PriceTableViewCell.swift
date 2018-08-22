//
//  PriceTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 22..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    // MARK: IBOutlet
    @IBOutlet weak var priceTextField: UITextField!
    
    // MARK: - Methods
    // MARK: addDoneButtonOnNumberPad
    private func addDoneButtonOnNumberPad() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // toolBar.items의 배열에 아이템이 들어가는 순서가 왼쪽부터이므로 오른쪽에 붙여주기 위한 코드
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self, action: #selector(didPressDoneButton))
        toolBar.items = [flexibleSpace, doneButton]
        priceTextField.inputAccessoryView = toolBar
    }
    @objc private func didPressDoneButton() {
        self.priceTextField.resignFirstResponder()
    }

    // MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.priceTextField.delegate = self
        self.addDoneButtonOnNumberPad()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
// MARK: - UITextFieldDelegate
extension PriceTableViewCell: UITextFieldDelegate {
    // MARK: shouldChangeCharactersIn
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // Uses the number format corresponding to your Locale
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current // 사용자의 지역 설정
        numberFormatter.maximumFractionDigits = 0 // 소수점 이하 최대 자릿수 -> 소수점 없을 예정이므로 0으로 설정
        if let inputString = priceTextField.text?.replacingOccurrences(of: numberFormatter.groupingSeparator,                                                                with: ""){ // ,(쉼표)를 제거
            var combinedString = inputString + string // 원래 있던 문자열과 새로 들어온 문자열 합침
            if numberFormatter.number(from: string) != nil { // 새로 입력된 값이 숫자만 이루어진 것이 아닌 경우
                // 입력된 값을 NSNumber형태로 바꾼 후 다시 String 형태로 변경!
                if let completedNumberString = numberFormatter.number(from: combinedString),
                    let completedString = numberFormatter.string(from: completedNumberString) {
                    priceTextField.text = completedString
                    return false
                }
            }else {
                if string == "" { // 백스페이스로 문자열이 없거나 숫자가 아닌 문자열이 들어왔을 경우
                    let lastInedex = combinedString.index(combinedString.endIndex, offsetBy: -1) // 문자를 하나씩 지우면 쉼표를 그만큼 앞으로 이동시켜야하므로
                    combinedString = String(combinedString[..<lastInedex])
                    if let completedNumberString = numberFormatter.number(from: combinedString), let completedString = numberFormatter.string(from: completedNumberString) {
                        priceTextField.text = completedString
                        return false
                    }
                }
            }
        }
        return true
    }
}
