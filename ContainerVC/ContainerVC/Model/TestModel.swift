//
//  TestModel.swift
//  ContainerVC
//
//  Created by SSY on 2018. 5. 21..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

struct Section {
    var title: String
    var items: [String]
    var isCollapsed: Bool
}

struct Category {
    var title: String
    var color: String
    var isCollapsed: Bool
    var items: [DetailData]
}

struct DetailData {
    var content: String // 제목
    var amount: String // 금액
    var date: Date // 날짜
    var memo: String? // 메모
    
}
