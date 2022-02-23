//
//  ActivityStruc.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/12/21.
//

import RealmSwift

 class Activity: Object {
     @objc dynamic var name: String = ""
     @objc dynamic var startTime: Double = 0
     @objc dynamic var endTime: Double = 0
}

extension Activity {
    @objc dynamic var duration: Int {
        return Int(endTime - startTime)
    }
}
