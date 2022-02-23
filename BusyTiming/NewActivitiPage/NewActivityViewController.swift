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
    private let timerVM = TimerVM()
    private var cancellableBag = Set<AnyCancellable>()
    private var activityTime = 0
    
    @IBOutlet weak var activityTimeLabel: UILabel!
    @IBOutlet weak var activityNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
   
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        viewModel.activityTimePublisher
        .assign(to: \.text, on: activityTimeLabel)
            .store(in: &cancellableBag)
        
        viewModel.saveIsEnablePubliser
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellableBag)
        
        activityNameTextField.textPublisher().assign(to: \.newActivityName, on: viewModel)
            .store(in: &cancellableBag)
    }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         activityTime = viewModel.getTimeActivity()
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         //saveButton.isEnabled = false
     }

     @IBAction func cancelButtonPressed(_ sender: UIButton) {
      activityNameTextField.text = ""
      dismiss(animated: true, completion: nil)
     }
     
     @IBAction func saveButtonPressed(_ sender: UIButton) {
         viewModel.saveNewActivity()
         activityNameTextField.text = ""
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
