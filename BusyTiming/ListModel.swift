//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation
import RealmSwift

class ActivitiesModel  {

    var activitiesViewModel: Results <Activity>!
    var activityName = ""
    var activityTime  = 0
    
    private struct ErrorBase {
        static let ErrorInitBase = "Realm initialization error"
        static let ErrorChangeBase = "Base change error"
    }
    
    init() {
        do{
            let realm = try Realm()
            self.activitiesViewModel = realm.objects(Activity.self)
        }
        catch {
            print(ErrorBase.ErrorInitBase)
        }
    }
    
    func addActivity(nameOfActivity: String, startTime:Double = 0.0, endTime:Double = 0.0) {
        let activity = Activity()
        activity.name = nameOfActivity
        activity.startTime = startTime
        activity.endTime = endTime
        do {
            let realm = try Realm()
            try realm.write {
            realm.add(activity)
            }
        } catch {
            print(ErrorBase.ErrorChangeBase)
        }
    }

    func deleteActivity(index: Int){
        do {
            let realm = try Realm()
            let activity = activitiesViewModel[index]
            try realm.write {
            realm.delete(activity)
            }
        } catch {
            print(ErrorBase.ErrorInitBase)
        }
    }
    
}

