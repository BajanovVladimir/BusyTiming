//
//  TimerViewController.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/1/21.
//

import UIKit

class TimerViewController: UIViewController {

    var timerCounting = false
    
    var  timer = MainTimerUse()
    
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisignStartBattons()
    }
    
    func setDisignStopBattons () {
        startStopButton.setTitle("◼︎", for:.normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    func setDisignStartBattons () {
        startStopButton.setTitle("▶︎", for:.normal)
        startStopButton.setTitleColor(UIColor.green, for: .normal)
    }

    @IBAction func startStopButtonPress(_ sender: UIButton) {
        if timerCounting {
         setDisignStartBattons()
            timerCounting = false
            timer.timer.invalidate()
           
        } else {
           setDisignStopBattons()
            timer.displayTimerDelegat = self
            timerCounting = true
            timer.timerOn()
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.displayTimerDelegat = self
    }
    
}

extension    TimerViewController: DisplayTimerProtocol {
    func displayTimer(result: String) {
        timerLabel.text  = result
    }
   
}
