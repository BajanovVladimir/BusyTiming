//
//  TimerModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation

class TimerModel {
    
    var lastTimePoint : Double = Date().timeIntervalSince1970
    func timerCounter () -> Double {
        let date = Date()
        let currentTime = date.timeIntervalSince1970
      return (currentTime - lastTimePoint)
    }
}


