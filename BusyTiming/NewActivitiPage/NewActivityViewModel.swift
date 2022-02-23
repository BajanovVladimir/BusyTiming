//
//  NewActivityViewModel.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import Foundation
import Combine

class NewActivityViewModel {
    
   
    
    var activityTimePublisher:AnyPublisher<String?,Never>{
        activityTimeSubject.eraseToAnyPublisher()
    }
    var saveIsEnablePubliser: AnyPublisher<Bool,Never>{
        saveIsEnableSubject.eraseToAnyPublisher()
    }
    
    @Published var saveIsEnabled:Bool
    @Published var newActivityName:String
    @Published var activityTime: Double
    
    @Published private var startTime: Double
    @Published private var endTime: Double
    
    private let lastTimePoint = LastTimePoint()
    private let activity = ActivitiesModel()
    private let activityTimeSubject = PassthroughSubject<String?,Never>()
    private let saveIsEnableSubject = PassthroughSubject<Bool,Never>()
    private var cancellebleBag = Set<AnyCancellable>()
    
    init(){
        startTime = lastTimePoint.lastTimeMarker.timeIntervalSince1970
        endTime = Date().timeIntervalSince1970
        activityTime = 0
        saveIsEnabled = false
        newActivityName = ""
        
        $startTime.sink{ [weak self] value in
            guard let endTime  = self?.endTime else {
                return
            }
            self?.activityTime = endTime - value
        }
        .store(in: &cancellebleBag)
        
        $endTime.sink{[weak self] value in
            guard let startTime = self?.startTime else {
                return
            }
            self?.activityTime = value - startTime
        }.store(in: &cancellebleBag)
        
        $activityTime.map({Int($0)}).map({$0.formatTime}).sink{[weak self] value in
            self?.activityTimeSubject.send(value)
        }.store(in: &cancellebleBag)
        
        $newActivityName.map {str -> Bool in
            let number = str.count
            if number > 2 && number < 10 {
                return true
            } else {
                return false
            }
        }
        .assign(to: \.saveIsEnabled, on: self)
        .store(in: &cancellebleBag)
        
        $saveIsEnabled.sink{[weak self] value in
            self?.saveIsEnableSubject.send(value)
        }.store(in: &cancellebleBag)
    }
    
    func saveNewActivity(){
        activity.addActivity(nameOfActivity: newActivityName, time: Int(activityTime))
        newActivityName = ""
        lastTimePoint.lastTimerMarkerReset()
    }
    
    func getTimeActivity(){
        startTime = lastTimePoint.lastTimeMarker.timeIntervalSince1970
        endTime = Date().timeIntervalSince1970
        activityTime = endTime - startTime
    }
    
    
}

