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

    let timerVM = TimerVM()
    
    let activity = ActivitiesModel()
    var selectedIndex = 0
    private var cancellableBag = Set<AnyCancellable>()

    @IBOutlet weak var activitiesTableView: UITableView!
   
    @IBOutlet weak var timerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // ***** Here is just subscription to updates of viewModel. no any logic.
        timerVM.durationString
            .flatMap { Just($0) }
            .assign(to: \.text, on: timerLabel)
            .store(in: &cancellableBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // ***** Just notifying viewModel about UI events.
        timerVM.timerStart()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // ***** Check if it works when the view will really disappear (now it doesn't 'cause there is no NewActivityController actually)
        timerVM.timerStop()
    }

    // ***** This should be moved to NewActivityViewController.
//    func  saveNewActivity(_ name:String?,_ time: Int) {
//        guard let newName = name else {
//            return
//        }
//        self.activity.addActivity(nameOfActivity: newName, time: time)
//        self.activitiesTableView.reloadData()
//    }



    
    @IBAction func  addActivityButtonPressed(_ sender: UIButton){
        // ***** This shiould be on new activity save.
//        timerVM.timerModel.lastTimePoint = Date().timeIntervalSince1970


        // ****** This is non needed here, NewActivityViewController has its own model and viewmodel that will create/load all needed data.
//        let time = timerVM.timerValueInt


        // ***** Showing the new viewcontroller instead, fill it with necessary functionality.
//        let alertController = UIAlertController(title: "Enter the name of  the Activity", message: "", preferredStyle: .alert)
//        alertController.addTextField { (textField) in
//            textField.placeholder = "New Activity"
//        }
//        let alertAction1 = UIAlertAction(title: "Create", style:.default) {
//            (alert) in
//            self.saveNewActivity(alertController.textFields?[0].text,time)
//        }
//        let alertAction2 = UIAlertAction(title: "Cancel", style:.destructive) {
//            (alert) in
//        }
//        alertController.addAction(alertAction1)
//        alertController.addAction(alertAction2)
//        alertController.view.layoutIfNeeded()
//        present(alertController, animated: true, completion: nil)

        show(NewActivityViewController(), sender: nil);
    }
}

extension TimerViewController: DisplayTimerProtocol, UITableViewDataSource, UITableViewDelegate {
   
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
