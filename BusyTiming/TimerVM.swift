//
//  TimerVM.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation

class TimerVM {
    
    let timerModel = TimerModel()
    var timerValueInt = 0
    
    func getCurrentTimeInString () -> String {
        timerValueInt = Int(timerModel.timerCounter())
        let time = timerValueInt.formatTime
        return time
    }
    
  
}

extension Int {
    var formatTime: String {
        let (h,m,s) = ((self / 3600), (self % 3600)/60, (self % 3600)%60)
        let h_string = h<10 ? "0\(h)" : "\(h)"
        let m_string = m<10 ? "0\(m)" : "\(m)"
        let s_string = s<10 ? "0\(s)" : "\(s)"
        return ("\(h_string):\(m_string):\(s_string)")
    }
}


