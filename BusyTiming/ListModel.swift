//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation

class  ListOfActivityModel  {

    var   ListOfActivity: [Activity] = []
    var selectedIndex = 0
    var  activityName = ""
    var  activityTime  = 0
    
    
    func addActivity(nameOfActivity: String, isCompleted:Bool = false, time:Int = 0) {
        let activity = Activity(nameInit: nameOfActivity, selectedInit: isCompleted,
                                timeInit: time)
        ListOfActivity.append(activity)
        if ListOfActivity.count == 1 {
            ListOfActivity[0].isSelected = true
            activityName = ListOfActivity[0].name
        }
    }

    func changeState (index: Int) {
        if index != selectedIndex {
            ListOfActivity[index].isSelected = !(ListOfActivity[index].isSelected)
            ListOfActivity[selectedIndex].isSelected = false
        }
        selectedIndex = index
        activityName = ListOfActivity[selectedIndex].name
    }

    func deleteActivity(index: Int){
        selectedIndex = 0
        ListOfActivity.remove(at: index)
    }
    
   
}
