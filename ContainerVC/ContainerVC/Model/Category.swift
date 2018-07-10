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
    var title: String // 분류 제목
    var color: String? // 임시 옵셔널로 정함 다시 수정할 계획
    var isCollapsed: Bool
    var items: [DetailData]
    
    init(title: String, color: String? = nil, isCollpased: Bool = true, items:[DetailData]) {
        self.title = title
        self.color = color
        self.isCollapsed = isCollpased
        self.items = items
    }
}

struct DetailData {
    var content: String // 제목
    var amount: String // 금액
    var date: Date? // 날짜 // 지금은 옵셔널로 함 다시 옵셔널 삭제 예정
    var memo: String? // 메모
    
    init(content: String, amount: String, date: Date? = nil, memo: String? = nil) {
        self.content = content
        self.amount = amount
        self.memo = memo
        self.date = date
    }
}
