//
//  TestModel.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 21..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

// 섹션 모델
struct Section {
    var title: CategoryTitle // 섹션 제목
    var items: [DetailData] // 데이터
    var color: UIColor
    init(title: CategoryTitle, items: [DetailData], color: UIColor) {
        self.title = title
        self.items = items
        self.color = color
    }
}

// 카테고리 분류 이름명
enum CategoryTitle: String {
    case food = "식비"
    case transportation = "교통비"
    case communication = "통신"
    case saving = "저축"
    case dailySupplies = "생활용품"
    case medicalCare = "의료"
    case education = "교육"
    case shopping = "쇼핑"
}
