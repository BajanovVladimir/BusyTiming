//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation

class ActivitiesModel  {

    var activity: [Activity] = []
    var selectedIndex = 0
    var activityName = ""
    var activityTime  = 0
    
    func addActivity(nameOfActivity: String, isCompleted:Bool = false, time:Int = 0) {
        let activityStr = Activity(nameInit: nameOfActivity, selectedInit: isCompleted,
                                timeInit: time)
        activity.append(activityStr)
        if activity.count == 1 {
            activity[0].isSelected = true
            activityName = activity[0].name
        }
    }

    func changeState (index: Int) {
        if index != selectedIndex {
            activity[index].isSelected = !(activity[index].isSelected)
            activity[selectedIndex].isSelected = false
        }
        selectedIndex = index
        activityName = activity[selectedIndex].name
    }

    func deleteActivity(index: Int){
        selectedIndex = 0
        activity.remove(at: index)
    }
}
