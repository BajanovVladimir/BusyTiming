//
//  TimerVM.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation

class TimerVM {
   
    var timerDelegate : DisplayTimerProtocol?
    var timerValueString = ""
    var timerValueInt = 0 {
        didSet {
            timerValueString = conversionOfTimeFromSecondsToString(timerValueInt)
            timerDelegate?.displayTimer(result: timerValueString)
        }
    }
        
        func  convertFromSecondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
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
    
    func conversionOfTimeFromSecondsToString(_ time: Int) -> String {
        let time = convertFromSecondsToHoursMinutesSeconds(time)
        return  convertFromTimeToString(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
}
