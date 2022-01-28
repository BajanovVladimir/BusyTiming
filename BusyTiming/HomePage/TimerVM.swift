//
//  TimerVM.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 12/2/21.
//

import Foundation
import Combine

// ***** Here is the main logic.
class TimerVM {

    // ***** Note that model property is `private`, so view cannot access it.
    private let timerModel = TimerModel()
    var durationString: AnyPublisher<String, Never> {
        durationStringSubject.eraseToAnyPublisher()
    }
    private let durationStringSubject = PassthroughSubject<String, Never>()
    let timer = Timer.publish(every: 1, on: .main, in: .common)

    private var cancellableBag = Set<AnyCancellable>()

    var cancellable: AnyCancellable?

    init() {
        // **** tale the timet values
         timer
            // **** Calculate difference between timer and value from model
            .map(duration(from:))
            // **** create a formatted string
            .map({$0.formatTime})
            .sink { [weak self] duration in
                // **** and publish it for View.
                self?.durationStringSubject.send(duration)
            }
            .store(in: &cancellableBag)
    }

    func timerStart () {
        cancellable = timer.connect() as? AnyCancellable
    }

    func timerStop() {
        cancellable?.cancel()
    }

    private func duration(from date: Date) -> Int {
        let currentTime = date.timeIntervalSince1970
        return Int(round(currentTime - timerModel.lastTimeMarker.timeIntervalSince1970))
    }

    deinit {
        cancellable?.cancel()
    }
}

// This might be reworked to use DateFormatter and moved to viewModel.
extension Int {
    var formatTime: String {
        let (h,m,s) = ((self / 3600), (self % 3600)/60, (self % 3600)%60)
        let h_string = h<10 ? "0\(h)" : "\(h)"
        let m_string = m<10 ? "0\(m)" : "\(m)"
        let s_string = s<10 ? "0\(s)" : "\(s)"
        return ("\(h_string):\(m_string):\(s_string)")
    }
}


