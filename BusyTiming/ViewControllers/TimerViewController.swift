//
//  TimerViewController.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/1/21.
//

import UIKit
import Combine



/*
 
 @IBOutlet weak var timerLabel: UILabel!
 
 @IBOutlet weak var saveActyvityButton: UIButton!

 override func viewDidLoad() {
     super.viewDidLoad()
     timerStart()
 }
 
 
 */

class TimerViewController: UIViewController {

    private var timerSubscription:AnyCancellable?
    let timerVM = TimerVM()
    
    let activity = ActivitiesModel()
    var selectedIndex = 0
    
    @IBOutlet weak var activitiesTableView: UITableView!
   
    @IBOutlet weak var timerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        timerStart()
    }
    
    func timerStart () {
         timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
        .scan(0,{(time, _) in
        return time+1
        })
        .sink(receiveValue: { [self] _ in
            timerLabel.text = timerVM.getCurrentTimeInString()
        })
    }
    
    func  saveNewActivity(_ name:String?,_ time: Int) {
        guard let newName = name else {
            return
        }
        self.activity.addActivity(nameOfActivity: newName, time: time)
        self.activitiesTableView.reloadData()
    }
    
    @IBAction func  addActivityButtonPressed(_ sender: UIButton){
        timerVM.timerModel.lastTimePoint = Date().timeIntervalSince1970
        let time = timerVM.timerValueInt
        let alertController = UIAlertController(title: "Enter the name of  the Activity", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New Activity"
        }
        let alertAction1 = UIAlertAction(title: "Create", style:.default) {
            (alert) in
            self.saveNewActivity(alertController.textFields?[0].text,time)
        }
        let alertAction2 = UIAlertAction(title: "Cancel", style:.destructive) {
            (alert) in
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        alertController.view.layoutIfNeeded()
        present(alertController, animated: true, completion: nil)
    }
}

extension    TimerViewController: DisplayTimerProtocol, UITableViewDataSource, UITableViewDelegate {
   
    func displayTimer(result: String) {
        timerLabel.text  = result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.activity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivitiesCell", for: indexPath)
        let currentList = activity.activity[indexPath.row]
        let currentName = currentList.name
        let currentTime = currentList.time
        let curentTimeString = currentTime.formatTime
        cell.textLabel?.text = currentName + "     " + curentTimeString
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activity.deleteActivity(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        activity.changeState(index: indexPath.row)
        tableView.reloadData()
    }
    
}
