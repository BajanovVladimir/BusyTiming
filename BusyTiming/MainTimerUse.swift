//
//  MainTimerUse.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/4/21.
//

import UIKit

class  MainTimerUse: DisplayTimerDelegat {
    
    var displayTimerDelegat: DisplayTimerProtocol?
    
    var timer = Timer()
    var secondTimer = 0
    var timerResultValue  = 0
    var timerCounting  = false
    var  timerResult: Int {
        get {
            return  timerResultValue
        }
    }
    
    func  timerOn  () {
        timer   = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc  func  timerCounter() -> Void {
        timerResultValue = timerResult + 1
        let time = convertFromSecondsToHoursMinutesSeconds(timerResult)
        let timeString = convertFromTimeToString(hours: time.0, minutes: time.1, seconds: time.2)
        displayTimerDelegat?.displayTimer(result: timeString)
    }
    
    func    convertFromSecondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return  (seconds / 3600, (seconds  % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func convertFromTimeToString (hours: Int, minutes: Int ,  seconds: Int) ->  String {
        var timeString = ""
        timeString += String(format: "%02d",  hours)
        timeString += ":"
        timeString += String(format: "%02d",  minutes)
        timeString += ":"
        timeString += String(format: "%02d",  seconds)
        return  timeString
    }
    
    
    func  timerOff() {
        timer.invalidate()
    }
    
}

    

 

