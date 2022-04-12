//
//  TimerViewController.swift
//  BusyTiming
//
//  Created by Владимир Бажанов on 11/1/21.
//
import UIKit
import Combine

class TimerViewController: UIViewController {

    private struct Constants {
        static let NewActivityVCKey = "NewActivitiVC"
        static let ActivitiesCellKey = "ActivitiesCell"
    }
    
   var timerVM = TimerVM()
    
    let activity = ActivitiesModel()
    var selectedIndex = 0
    private var cancellableBag = Set<AnyCancellable>()

    @IBOutlet weak var activitiesTableView: UITableView!
   
    @IBOutlet weak var timerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        timerVM.durationString
            .flatMap { Just($0) }
            .assign(to: \.text, on: timerLabel)
            .store(in: &cancellableBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ***** Just notifying viewModel about UI events.
        timerVM.timerStart()
        activitiesTableView.reloadData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // ***** Check if it works when the view will really disappear (now it doesn't 'cause there is no NewActivityController actually)
        timerVM.timerStop()
    }
    
    @IBAction func  addActivityButtonPressed(_ sender: UIButton){

        let newActivityVC: NewActivityViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.NewActivityVCKey) as! NewActivityViewController
        return viewController
    }()
        newActivityVC.modalPresentationStyle = .fullScreen
        newActivityVC.modalTransitionStyle = .coverVertical
        present(newActivityVC, animated: true, completion: nil)
    }
}

extension    TimerViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.activitiesViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivitiesCell", for: indexPath)
        let currentList = activity.activitiesViewModel[indexPath.row]
        let currentName = currentList.name
        let currentTime = currentList.duration
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
    
}

