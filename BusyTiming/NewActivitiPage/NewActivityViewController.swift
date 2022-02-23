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
    let timerVM = TimerVM()
    private var cancellableBag = Set<AnyCancellable>()
    private var activityTime = 0
    override func viewDidLoad() {
         super.viewDidLoad()
        
        viewModel.activityTimePublisher.flatMap{Just($0)}
        .assign(to: \.text, on: activityTimeLabel)
            .store(in: &cancellableBag)
        
        activityNameTextField.textPublisher().assign(to: \.newActivityName, on: viewModel)
            .store(in: &cancellableBag)
    }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         activityTime = viewModel.getTimeActivity()
         
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
         dismiss(animated: true, completion: nil)
     }
 }

extension UITextField {
    func textPublisher() -> AnyPublisher<String,Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            .map {($0.object as? UITextField)?.text ?? ""}
            .eraseToAnyPublisher()
    }
}
