//
//  TimerModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation

class TimerModel {
    var timer = Timer()
    var timerVM  = TimerVM()
    var lastTimePoint: Double  = 0.0
    var  timeResult = 0.0
    let date = Date()
    
    func timerOn() {
        let date = Date()
        lastTimePoint  = date.timeIntervalSince1970
        timer  =  Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(timerCounter), userInfo: nil, repeats: true)
    }
        
    @objc func  timerCounter() -> Void {
            let date   = Date()
            let currentTime = date.timeIntervalSince1970
            timeResult = currentTime - lastTimePoint
            timerVM.timerValueInt =  Int(timeResult)
    }
    
    func  timerOff() {
        timer.invalidate()
    }
    
}
