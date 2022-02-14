//
//  NewActivityViewController.swift
//  BusyTiming
//
//  Created by Konstantin Elizarov on 28.01.2022.
//

import UIKit
import Combine


class NewActivityViewController: UIViewController {
    private let viewModel = NewActivityViewModel()
    
    @IBOutlet weak var activityTimeLabel: UILabel!
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var cancelleble: AnyCancellable?

    override func viewDidLoad() {
         super.viewDidLoad()
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         activityTimeLabel.text = viewModel.getTimeActivity()
         let activityNameTextFieldPublisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: activityNameTextField)
             .map{$0.object as? UITextField}
             .compactMap{$0?.text}.eraseToAnyPublisher()
         
         cancelleble = activityNameTextFieldPublisher.map{str -> Bool in
                 let number = str.count
             if number > 2 && number < 10 {
                 return true
             } else {
                 return false
             }
         }.assign(to: \.isEnabled, on: saveButton)
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         cancelleble?.cancel()
         saveButton.isEnabled = false
     }

     @IBAction func cancelButtonPressed(_ sender: UIButton) {
      activityNameTextField.text = ""
      dismiss(animated: true, completion: nil)
     }
     
     @IBAction func saveButtonPressed(_ sender: UIButton) {
         let activitiesModel = ActivitiesModel()
         guard let newName = activityNameTextField.text  else {
             return
         }
         activitiesModel.addActivity(nameOfActivity: newName, time: viewModel.time)
         activityNameTextField.text = ""
         viewModel.lastTimePoint.lastTimerMarkerReset()
         dismiss(animated: true, completion: nil)
     }
 }
