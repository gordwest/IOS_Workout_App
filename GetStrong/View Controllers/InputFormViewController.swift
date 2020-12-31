//
//  InputFormViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-07-15.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

protocol InputFormViewControllerDelegate {
    func addNewLogEntry(logEntry: LogEntry)
    func save(data: [LogEntry]) -> Bool
    func getLogEntries() -> Array<LogEntry>
}

class InputFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    var delegate: InputFormViewControllerDelegate!
    var repsPickerData:[String] = [String]()
    
    let repsPicker = UIPickerView()
    let rpePicker = UIPickerView()
    
    let repRange = ["12","11","10","9","8","7","6","5","4","3","2","1"]
    let rpeRange = ["10","9.5","9","8.5","8","7.5","7","6.5","6"]
    
    // MARK: IBOutlets
    @IBOutlet weak var excersieTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: IBActions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let newLogEntry = LogEntry(date: asString(date: datePicker.date), exercise: excersieTextField.text ?? "", weight: Int(weightTextField.text!) ?? 0, reps: Int(repsTextField.text!) ?? 0, rpe: rpeTextField.text ?? "")
        delegate.addNewLogEntry(logEntry: newLogEntry)
        navigationController?.popViewController(animated: true)
        print(String(describing: delegate.save(data: delegate.getLogEntries())))
    }
    /*
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let newLogEntry = LogEntry(date: asString(date: datePicker.date), exercise: excersieTextField.text ?? "", weight: Int(weightTextField.text!) ?? 0, reps: Int(repsTextField.text!) ?? 0, rpe: rpeTextField.text ?? "")
        delegate.addNewLogEntry(logEntry: newLogEntry)
        navigationController?.popViewController(animated: true)
        print(String(describing: delegate.save(data: delegate.getLogEntries())))
    }*/
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .compact
        datePicker?.datePickerMode = .date
        datePicker.backgroundColor = .lightGray
        datePicker.tintColor = .black
        
        repsPicker.delegate = self
        repsPicker.dataSource = self
        rpePicker.delegate = self
        rpePicker.dataSource = self
        
        repsTextField.delegate = self
        rpeTextField.delegate = self
               
        repsTextField.inputView = repsPicker
        rpeTextField.inputView = rpePicker
    }
    
    // convert date to string
    func asString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter.string(from: date as Date)
    }
    
    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == repsPicker {
            return repRange[row]
        }
        else if pickerView == rpePicker{
             return rpeRange[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == repsPicker {
            return repRange.count
        }
        else if pickerView == rpePicker{
            return rpeRange.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == repsPicker {
            repsTextField.text = repRange[row]
        }
        else if pickerView == rpePicker {
            rpeTextField.text = rpeRange[row]
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == repsTextField && repsTextField.text == "" {
            repsTextField.text = repRange[0]
        }
        else if textField == rpeTextField && rpeTextField.text == "" {
            rpeTextField.text = rpeRange[0]
        }
    }
    
    // hide keyboard/picker when touch even occurs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
