//
//  TestModel.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 21..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

//struct Category {
//    var title: CategoryTitle?  // 분류 제목
//    var color: UIColor? // 분류 색깔
//    var isCollapsed: Bool = true
//    var items: [DetailData] // 디테일 데이터
//
//
//}
struct Section {
    var title: CategoryTitle// 섹션 제목
    var items = [DetailData]() // 데이터
    mutating func add(_ item: DetailData) {
        self.items.append(item)
    }
    init(title: CategoryTitle) {
        self.title = title
    }
}
//struct Category {
//
//    var title: CategoryTitle? // 분류 제목
//    var color: UIColor?
//    var isCollapsed: Bool = true
//    var items: [DetailData]
//
//
//    init(title: CategoryTitle? = nil, color: UIColor? = nil, isCollapsed: Bool = true, items: [DetailData]) {
//        self.title = title
//        self.color = color
//        self.isCollapsed = isCollapsed
//        self.items = items
//    }
//
//}

// 카테고리 분류 이름명
enum CategoryTitle: String {
    case food = "식비"
    case transportation = "교통비"
    case communication = "통신"
    case saving = "저축"
    case dailySupplies = "생활용품"
    case medicalCare = "의료"
}
