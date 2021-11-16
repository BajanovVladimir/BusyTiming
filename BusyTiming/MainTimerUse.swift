//
//  MainTimerUse.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/4/21.
//

import UIKit

class  MainTimerUse {
    
    var displayTimerDelegat: DisplayTimerProtocol?
    
    var timer = Timer()
    var timerResultValue  = 0
    var totalTimeInt = 0
    var totalTimeString  = "00:00:00"
    var timerCounting  = false
    var timerResult = 0
    var activity = ListOfActivityModel()
    
    func  timerOn() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @objc  func  timerCounter() -> Void {
        timerResult = timerResult + 1
        let timeString = conversionOfTimeFromSecondsToString(timerResult)
        displayTimerDelegat?.displayTimer(result: timeString)
    }
    
    func calculateTotalTime() {
        totalTimeInt = totalTimeInt + timerResult
        totalTimeString  = conversionOfTimeFromSecondsToString(totalTimeInt)
    }
    
    func conversionOfTimeFromSecondsToString(_ time: Int) -> String {
        let time = convertFromSecondsToHoursMinutesSeconds(time)
        return  convertFromTimeToString(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    func    convertFromSecondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds  % 3600) / 60, (seconds % 3600) % 60)
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

    

 

