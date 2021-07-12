//
//  Extennsion+String.swift
//  Sfera view v1
//
//  Created by Максим on 08.07.2021.
//

import UIKit

extension String {
    enum colors: String {
        case gray = "gray"
        case grayDark = "grayDark"
        case grayTitle = "grayTitle"
        
    }
    enum titles: String {
        case newTimer = "Добавление таймеров"
        case timers = "Таймеры"
    }
    
    enum buttons: String {
        case addTimer = "Добавить"
    }
    
    enum placeholders: String {
        case nameTimer = "Название таймера"
        case secTime = "Время в секундах"
    }
}
