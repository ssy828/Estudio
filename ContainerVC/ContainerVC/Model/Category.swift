//
//  TestModel.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 21..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

//struct Section {
//    var title: String
//    var items: [String]
//    var isCollapsed: Bool
//}

struct Category {
    
    var title: CategoryTitle? // 분류 제목
    var color: UIColor?
    var isCollapsed: Bool
    var items: [DetailData]
    
    init(title: CategoryTitle? = nil, color: UIColor? = nil, isCollpased: Bool = true, items:[DetailData]) {
//        if let title = title {
//            self.title = title
//        }
        self.title = title
        self.color = color
        self.isCollapsed = isCollpased
        self.items = items
    }

}
// 카테고리 분류 이름명
enum CategoryTitle: String {
    case food = "식비"
    case transportation = "교통비"
    case communication = "통신비"
    case saving = "저축"
    case dailySupplies = "생활용품"
    case medicalCare = "의료"
}
