//
//  DetailData.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 18..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation

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
