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
    
    let repRange = ["15","14","13","12","11","10","9","8","7","6","5","4","3","2","1"]
    let rpeRange = ["10","9.5","9","8.5","8","7.5","7","6.5","6"]
    
    // MARK: IBOutlets
    @IBOutlet weak var excersieTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: IBActions
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let newLogEntry = LogEntry(date: asString(date: datePicker.date), exercise: excersieTextField.text ?? "", weight: Int(weightTextField.text!) ?? 0, reps: Int(repsTextField.text!) ?? 0, rpe: rpeTextField.text ?? "")
        delegate.addNewLogEntry(logEntry: newLogEntry)
        self.dismiss(animated: true, completion: nil)
        print(String(describing: delegate.save(data: delegate.getLogEntries())))
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style buttons
        addShadow(button: saveButton, cornerRad: 15)
        addShadow(button: cancelButton, cornerRad: 15)
        
        initializeToolBar()
        
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
    
    func addShadow(button: UIButton, cornerRad: CGFloat) {
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.cornerRadius = cornerRad
    }
    
    // convert date to string
    func asString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter.string(from: date as Date)
    }
    
    // MARK: Tool bar
    // create/add tool bar to UIPickerViews
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
    
    // tool bar done button - closes UIPickerView
    @objc func donePressed(sender: UIBarButtonItem) {
        repsTextField.resignFirstResponder()
        rpeTextField.resignFirstResponder()
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
    
    // hide keyboard/picker when touch event occurs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
