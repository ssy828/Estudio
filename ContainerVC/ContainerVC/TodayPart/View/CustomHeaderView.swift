//
//  CustomHeaderView.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 20..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit
// 클래스 전용 프로토콜
protocol CustomHeaderViewDelegate:class {
    func toggleSection(_ button: UIButton)
}

class CustomHeaderView: UITableViewHeaderFooterView {
    
    // IBAction
    @IBAction func openCloseBtn(_ sender: UIButton) {
        self.delegate?.toggleSection(sender)
    }
    // IBOutlet
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var openCloseButton: UIButton!
    
    // Properties
    weak var delegate: CustomHeaderViewDelegate? // 델리게이트 패턴 사용
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
}
