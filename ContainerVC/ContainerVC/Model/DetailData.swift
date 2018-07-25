//
//  DetailData.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 18..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

struct DetailData {
    
    var title: CategoryTitle
    var content: String // 제목
    var amount: String // 금액
    var date: Date? // 날짜 // 지금은 옵셔널로 함 다시 옵셔널 삭제 예정
    var memo: String? // 메모
    var color: UIColor? // 색깔
    
    init(content: String, amount: String, color: UIColor? = nil, title: CategoryTitle) {
        self.content = content
        self.amount = amount
        self.color = color
        self.title = title
    }
}
