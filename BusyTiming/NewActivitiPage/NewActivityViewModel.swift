//
//  NewActivityViewModel.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import Foundation

class NewActivityViewModel {
    
    let lastTimePoint = LastTimePoint()
    let activity = ActivitiesModel()
    var time = 0
 
    func getTimeActivity() -> String {
        let newActivityStartDate = lastTimePoint.lastTimeMarker
        let newActivityEndDate = Date()
         time = Int(newActivityEndDate.timeIntervalSince1970 - newActivityStartDate.timeIntervalSince1970)
        return time.formatTime
    }
    
}

