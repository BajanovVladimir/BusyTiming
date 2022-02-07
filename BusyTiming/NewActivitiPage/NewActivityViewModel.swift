//
//  NewActivityViewModel.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import Foundation

class NewActivityViewModel {
    private let model = LastTimePoint() // That's why TimerModel should be renamed. It may be reused so it should have more generic name.

    var newActivityStartDate: Date
    var newActivityEndDate: Date
    let time: Double
    
   init() {
        newActivityStartDate = model.lastTimeMarker
        newActivityEndDate = Date()
       time = Double ( newActivityEndDate.timeIntervalSince1970 - newActivityStartDate.timeIntervalSince1970)
    }
    
}
