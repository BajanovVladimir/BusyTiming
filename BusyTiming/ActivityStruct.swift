//
//  ActivityStruc.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/12/21.
//

import RealmSwift

 class Activity: Object {
     @objc dynamic var name: String = ""
     @objc dynamic var isSelected:  Bool = false
     @objc dynamic var time: Int = 0
}
