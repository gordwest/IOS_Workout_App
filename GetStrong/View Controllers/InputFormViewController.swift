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

class InputFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Variables
    var delegate: InputFormViewControllerDelegate!
    var repsPickerData:[String] = [String]()
    
    let repsPicker = UIPickerView()
    let rpePicker = UIPickerView()
    
    let repRange = ["8","7","6","5","4","3","2","1"]
    let rpeRange = ["10","9.5","9","8.5","8","7.5","7","6.5","6"]
    
    // MARK: IBOutlets
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var excersieTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    
    // MARK: IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let newLogEntry = LogEntry(date: dateTextField.text!, exercise: excersieTextField.text!, weight: weightTextField.text!,
                                   reps: repsTextField.text!, rpe: rpeTextField.text!)
        delegate.addNewExerciseEntry(logEntry: newLogEntry)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repsPicker.delegate = self
        repsPicker.dataSource = self
        rpePicker.delegate = self
        rpePicker.dataSource = self
               
        repsTextField.inputView = repsPicker
        rpeTextField.inputView = rpePicker
        
        dateTextField.text = todayDate() // initialize as today's date by default
        initializeDatePicker()
        initializeToolBar()
    }
    
    // get today's date
    func todayDate() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter.string(from: NSDate() as Date)
    }
    
    // update textfield with datepicker value
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    // Mark: UIDatePicker
    func initializeDatePicker() {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = UIDatePicker.Mode.date
        datepicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        dateTextField.inputView = datepicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        toolbar.barStyle = UIBarStyle.black
        toolbar.tintColor = UIColor.white
        
        let todayButton = UIBarButtonItem(title: "Today", style: UIBarButtonItem.Style.plain, target: self, action: #selector(todayPressed(sender:)))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed(sender:)))
        let clearButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(clearPressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([clearButton, flexButton, todayButton, flexButton, doneButton], animated: true)
        dateTextField.inputAccessoryView = toolbar
    }
    
    // MARK: UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == repsPicker {
            return repRange[row]

        } else if pickerView == rpePicker{
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
        } else if pickerView == rpePicker{
            rpeTextField.text = rpeRange[row]
        }
    }
    
    // MARK: Tool bar
    // create tool bar for UIPickerViews
    func initializeToolBar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        toolbar.barStyle = UIBarStyle.black
        toolbar.tintColor = UIColor.white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed(sender:)))
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([flexButton, flexButton, doneButton], animated: true)
        rpeTextField.inputAccessoryView = toolbar
        repsTextField.inputAccessoryView = toolbar
    }
    
    @objc func clearPressed(sender: UIBarButtonItem) {
        dateTextField.text = ""
        dateTextField.resignFirstResponder()
    }
    
    @objc func todayPressed(sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = formatter.string(from: NSDate() as Date)
        dateTextField.resignFirstResponder()
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
        repsTextField.resignFirstResponder()
        rpeTextField.resignFirstResponder()
    }
}
