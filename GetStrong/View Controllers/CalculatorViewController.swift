//
//  CalculatorViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-16.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit
import QuartzCore

class CalculatorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    let repsPicker = UIPickerView()
    let rpePicker = UIPickerView()
    
    let repRange = ["8","7","6","5","4","3","2","1"]
    let rpeRange = ["10","9.5","9","8.5","8","7.5","7"]
    
    // MARK: IBOutlets
    @IBOutlet weak var DaySegmentControl: UISegmentedControl!
    @IBOutlet weak var WeekSegmentControl: UISegmentedControl!
    @IBOutlet weak var TopsetLabel: UILabel!
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var rpeTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var e1RMLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func calculateClick(_ sender: Any) {
        assignLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopsetLabel.layer.cornerRadius = 10
        TopsetLabel.layer.masksToBounds = true
        e1RMLabel.layer.cornerRadius = 10
        e1RMLabel.layer.masksToBounds = true
        
        repsPicker.delegate = self
        repsPicker.dataSource = self
        rpePicker.delegate = self
        rpePicker.dataSource = self
        
        repsTextField.delegate = self
        rpeTextField.delegate = self
        
        repsTextField.inputView = repsPicker
        rpeTextField.inputView = rpePicker
        
        initializeToolBar()
    }
    
    // MARK: UIPickerView functions
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
        } else if pickerView == rpePicker{
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

    // MARK: View lifecycle methods
    // assign output labels for calculation based off user input
    func assignLabels() {
        // Assign variables from user input
        let weightEntry = Int(weightTextField.text!)
        let repsEntry  = Int(repsTextField.text!)
        let rpeEntry = Double(rpeTextField.text!)
        let dayChoice = DaySegmentControl.titleForSegment(at: DaySegmentControl.selectedSegmentIndex)!
        let weekChoice = WeekSegmentControl.titleForSegment(at: WeekSegmentControl.selectedSegmentIndex)!
        let e1RM = Calculate.getE1RM(weight: weightEntry ?? 0, reps: repsEntry ?? 0, rpe: rpeEntry ?? 0.0)
        let reps = Calculate.getReps(day: dayChoice, week: weekChoice)
        // Assign labels if fields are filled out
        if weightEntry != nil && repsEntry != nil && rpeEntry != nil { // check if all fields have values
            //RepsLabel.text = String(reps)
            e1RMLabel.text = String(e1RM) + "lbs"
            TopsetLabel.text = Calculate.getTopSet(e1RM: e1RM, weight: weightEntry ?? 0, reps: reps, rpe: rpeEntry ?? 0) + "lbs for " + String(reps)
        }
        else {
            Alert.showBasicAlert(on: self, with: "Invalid Inputs", message: "Fill out all fields and try again")
        }
    }
    
    // get text field value and convert to int
    func getInput(field:UITextField) -> Int{
        let input = field.text!
        return Int(input) ?? 0
    }
    
    // hide keyboard/picker when touch even occurs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

