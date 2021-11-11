//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation

struct Entry {
    var Name: String
    var isSelected:  Bool
    var Time: Int
}

var   ListOfAffairs: [[String: Any]] {
    get {
        if var array = UserDefaults.standard.array(forKey: "ListOfAffairsKey") as? [[String:Any]] {
            if array.count == 1 {
                array[0]["isSelected"] = true
            }
        return array
        } else {
            return []
        }
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "ListOfAffairsKey")
        UserDefaults.standard.synchronize()
    }
}

var selectedIndex: Int {
    get {
        if let indexValue  = UserDefaults.standard.integer(forKey: "indexKey") as? Int {
            return indexValue
        } else {
            return 0
        }
    }
    set {
            UserDefaults.standard.set(newValue, forKey: "indexKey")
            UserDefaults.standard.synchronize()
    }
}
var  affairName = ""

func addAffair(_ nameOfAffair: String, isCompleted:Bool = false, time:Int = 0) {
    ListOfAffairs.append(["Name": nameOfAffair,"isSelected": isCompleted, "Time":  time])
}

func changeState (index: Int) {
    if index != selectedIndex {
        ListOfAffairs[index]["isSelected"] = !(ListOfAffairs[index]["isSelected"] as! Bool)
        ListOfAffairs[selectedIndex]["isSelected"] = false
    }
    selectedIndex = index
    affairName = ListOfAffairs[selectedIndex]["Name"]  as!  String
    
}

func deleteAffairs(index: Int){
    selectedIndex = 0
    ListOfAffairs.remove(at: index)
}
