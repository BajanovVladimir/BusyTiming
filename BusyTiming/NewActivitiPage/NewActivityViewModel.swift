//
//  NewActivityViewModel.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import Foundation
import Combine

class NewActivityViewModel {
    
    let lastTimePoint = LastTimePoint()
    let activity = ActivitiesModel()
   
    @Published private var startTime: Double
    @Published private var endTime: Double
    @Published  var activityTime: Double
    private let activityTimeSubject = PassthroughSubject<String,Never>()
    var activityTimePublisher:AnyPublisher<String,Never>{
        activityTimeSubject.eraseToAnyPublisher()
    }
    private var cancellebleBag = Set<AnyCancellable>()
    
    
    init(){
        startTime = lastTimePoint.lastTimeMarker.timeIntervalSince1970
        endTime = Date().timeIntervalSince1970
        activityTime = 0
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
        
    }
    
    func getTimeActivity(){
        activityTime = endTime - startTime
    }
    
    
}

