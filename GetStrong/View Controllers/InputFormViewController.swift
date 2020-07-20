//
//  InputFormViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-07-15.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

protocol InputFormViewControllerDelegate {
    func addNewExerciseEntry(logEntry: LogEntry)
}

class InputFormViewController: UIViewController {
    
    // MARK: Variables
    
    var delegate: InputFormViewControllerDelegate!
    
    // MARK: IBOutlets

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var excersieTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    
    // MARK: IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let newLogEntry = LogEntry(date: dateTextField.text!,
                                exercise: excersieTextField.text!,
                                weight: weightTextField.text!,
                                reps: repsTextField.text!,
                                rpe: rpeTextField.text!)
        
        delegate.addNewExerciseEntry(logEntry: newLogEntry)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(InputFormViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        dateTextField.inputView = datePicker
        
    }

    // assign date field using date picker
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    // hides keyboard/picker when touch even occurs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
