//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation

struct Activity {
    var name: String
    var isSelected:  Bool
    var time: Int
    
    init(nameInit: String, selectedInit:Bool, timeInit:Int) {
      name = nameInit
      isSelected = selectedInit
        time = timeInit
    }
}

var   ListOfActivity: [Activity] = []
    
var selectedIndex = 0
var  activityName = ""

func addActivity(nameOfActivity: String, isCompleted:Bool = false, time:Int = 0) {
    let activity = Activity(nameInit: nameOfActivity, selectedInit: isCompleted, timeInit: time)
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
