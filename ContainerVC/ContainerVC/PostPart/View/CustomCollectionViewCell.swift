//
//  CustomCollectionViewCell.swift
//  ContainerVC
//
//  Created by SSY on 2018. 8. 5..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import UIKit


class CustomCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    private var buttonTitle: String?
    private var buttonColor: UIColor?
    public var didAddHandler: ((UIColor?,String?) -> Void)? // 버튼 색깔,타이틀 넘기기
    // MARK: IBOutlet
    @IBOutlet weak var colorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
