//
//  LastTimePoint.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation

// ***** I kept it 'TimerModel' for now to not confuse you as you are familiar with this name.
// ***** Later it should be renamed to something like SavedTimePointRepository
class LastTimePoint {

    private struct Constants {
        static let lastTimeMarkerKey = "lastTimeMarkerKey"
    }

    // ***** The model provides the raw data. From storage or from server or both.
    // ***** By the way, check if we really need Data here, possibly Double is enough and even more suitable.
    var lastTimeMarker: Date {
        get {
            guard let savedTimeInterval = UserDefaults.standard.value(forKey: Constants.lastTimeMarkerKey) as? Double else {
                let firstDate = Date()
                updateValueInUserDefaults(newValue: firstDate.timeIntervalSince1970)
                return firstDate
            }

            return Date(timeIntervalSince1970: savedTimeInterval)
        }
        set {
            updateValueInUserDefaults(newValue: newValue.timeIntervalSince1970)
        }
    }

    private func updateValueInUserDefaults(newValue: Double) {
        UserDefaults.standard.set(newValue, forKey: Constants.lastTimeMarkerKey)
    }
    func lastTimerMarkerReset(){
        UserDefaults.standard.removeObject(forKey: Constants.lastTimeMarkerKey)
        UserDefaults.standard.synchronize()
        
    }
}


