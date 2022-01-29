//
//  NewActivityViewModel.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import Foundation

class NewActivityViewModel {
    private let model = TimerModel() // That's why TimerModel should be renamed. It may be reused so it should have more generic name.

    var newActivityStartDate: Date
    var newActivityEndDate: Date

    init() {
        newActivityStartDate = model.lastTimeMarker
        newActivityEndDate = Date()
    }
}
