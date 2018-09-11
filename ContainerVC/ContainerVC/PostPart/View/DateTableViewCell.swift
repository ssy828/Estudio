//
//  DateTableViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 9. 10..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
// MARK: - DateTableViewCellDelegate
protocol DateTableViewCellDelegate: class {
    func pass(date: String)
}

class DateTableViewCell: UITableViewCell {

    // MARK: properties
    weak var delegate: DateTableViewCellDelegate?
    // MARK: IBOutlet
    @IBOutlet weak var datePicker: UIDatePicker!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func didPickDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "MM월dd일 EEEE"
        let currentDate = dateFormatter.string(from: sender.date)
        self.delegate?.pass(date: currentDate)
    }

}
