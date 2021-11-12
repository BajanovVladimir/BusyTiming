//
//  ActivityStruc.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/12/21.
//

import Foundation

struct Activity {
    var name: String
    var isSelected:  Bool
    var time: Int
    
    init(nameInit: String, selectedInit:Bool, timeInit:Int) {
      name = nameInit
      isSelected = selectedInit
        time = timeInit
    }
}
