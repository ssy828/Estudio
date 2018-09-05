
//
//  CategoryColor.swift
//  ContainerVC
//
//  Created by SSY on 2018. 7. 17..
//  Copyright © 2018년 LittleMe. All rights reserved.
//

import Foundation
import UIKit

enum CategoryColor {
    case red, orange, yellow, yellowGreen, green
    
    var color: UIColor {
        switch self {
        case .red:
            return UIColor(red: 255, green: 126, blue: 121, alpha: 1)
        case .orange:
            return UIColor(red: 255, green: 212, blue: 121, alpha: 1)
        case .yellow:
            return UIColor(red: 255, green: 252, blue: 121, alpha: 1)
        case .yellowGreen:
            return UIColor(red: 212, green: 251, blue: 121, alpha: 1)
        case .green:
            return UIColor(red: 115, green: 250, blue: 121, alpha: 1)
        }
    }
}
