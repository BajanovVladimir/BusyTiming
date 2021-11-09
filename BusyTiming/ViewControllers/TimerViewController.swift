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
    let vc = TableViewListController()
    var i = 0
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var saveTimerLabel: UILabel!
    @IBOutlet weak var saveTimerButton: UIButton!
    @IBOutlet weak var affairLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.totalTimeInt = ListOfAffairs[selectedIndex]["Time"] as? Int ?? 0
        saveTimerLabel.text = timer.conversionOfTimeFromSecondsToString(timer.totalTimeInt)
        affairLabel.text =  affairName
        setDisignStartBattons()
        setDisignSaveTimeButtonHide()
    }
    
    func setDisignStopBattons () {
        startStopButton.setTitle("◼︎", for:.normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    func setDisignSaveTimeButtonHide () {
        saveTimerButton.setTitle("Save", for: .normal)
        saveTimerButton.setTitleColor(UIColor.gray, for: .normal)
    }
    
    func setDisignSaveTimeButtonShow () {
        saveTimerButton.setTitle("Save", for: .normal)
        saveTimerButton.setTitleColor(UIColor.green, for: .normal)
    }
    
    func setDisignStartBattons () {
        startStopButton.setTitle("▶︎", for:.normal)
        startStopButton.setTitleColor(UIColor.green, for: .normal)
    }

    @IBAction func startStopButtonPress(_ sender: UIButton) {
        if timerCounting {
            setDisignStartBattons()
            setDisignSaveTimeButtonShow()
            timerCounting = false
            timer.timer.invalidate()
            timer.calculateTotalTime()
        } else {
            setDisignStopBattons()
            timer.timerResultValue = 0
            timer.displayTimerDelegat = self
            timerCounting = true
            timer.timerOn()
        }
    }
    
    @IBAction func saveTimeButtonPressed(_ sender: UIButton) {
        if !timerCounting {
            setDisignSaveTimeButtonHide()
            saveTimerLabel.text = timer.totalTimeString
            
        }
    }
}

extension    TimerViewController: DisplayTimerProtocol {
    func displayTimer(result: String) {
            timerLabel.text  = result
    }
}
