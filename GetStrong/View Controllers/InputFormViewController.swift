//
//  InputFormViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-07-15.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class InputFormViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var excersieTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(InputFormViewController.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        dateTextField.inputView = datePicker
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        let date = dateTextField.text!
        let exercise = excersieTextField.text!
        let weight = weightTextField.text!
        let reps = repsTextField.text!
        let rpe = repsTextField.text!
        
        let logEntry = LogEntry(date: date, exercise: exercise, weight: weight, reps: reps, rpe: rpe)
        logEntries.append(logEntry)
        print(HistoryViewController().save(data: logEntries))
        
        self.dismiss(animated:true, completion: nil) // unload the current view controller
    }
    
    // assign date field using date picker
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
