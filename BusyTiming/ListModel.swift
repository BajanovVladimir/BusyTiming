//
//  ListModel.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/5/21.
//

import Foundation
import RealmSwift

class ActivitiesModel  {

    var activityBase: Results <Activity>!
    var selectedIndex = 0
    var activityName = ""
    var activityTime  = 0
    
    private struct ErrorBase {
        static let ErrorInitBase = "Realm initialization error"
        static let ErrorChangeBase = "Base change error"
    }
    
    init() {
        do{
            let realm = try Realm()
            self.activityBase = realm.objects(Activity.self)
        }
        catch {
            print(ErrorBase.ErrorInitBase)
        }
    }
    
    func addActivity(nameOfActivity: String, isCompleted:Bool = false, time:Int = 0) {
        let activity = Activity()
        activity.name = nameOfActivity
        activity.time = time
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
            let activity = activityBase[index]
            try realm.write {
            realm.delete(activity)
            }
        } catch {
            print(ErrorBase.ErrorInitBase)
        }
    }
    
}

