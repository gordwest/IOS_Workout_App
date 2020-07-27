//
//  CalculatorViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-16.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: Variables
    let repsPicker = UIPickerView()
    let rpePicker = UIPickerView()
    
    let repRange = ["1","2","3","4","5","6","7","8"]
    let rpeRange = ["6","6.5","7","7.5","8","8.5","9","9.5","10"]
    
    // MARK: IBOutlets
    @IBOutlet weak var DaySegmentControl: UISegmentedControl!
    @IBOutlet weak var WeekSegmentControl: UISegmentedControl!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var RepsLabel: UILabel!
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
        
        repsPicker.delegate = self
        repsPicker.dataSource = self
        rpePicker.delegate = self
        rpePicker.dataSource = self
        
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
        let weightEntry = getInput(field: weightTextField)
        let repsEntry  = getInput(field: repsTextField)
        let rpeEntry = getInput(field: rpeTextField)
        let dayChoice = DaySegmentControl.titleForSegment(at: DaySegmentControl.selectedSegmentIndex)!
        let weekChoice = WeekSegmentControl.titleForSegment(at: WeekSegmentControl.selectedSegmentIndex)!
        
        // Assign estimate 1RM label
        let e1RMString = calculate1RM(weight: weightEntry, reps: repsEntry, rpe: Double(rpeEntry))
        e1RMLabel.text = e1RMString
        
        // Assign Reps label
        let repsString = calculateReps(day: dayChoice, week: weekChoice)
        if weightEntry != 0 || repsEntry != 0 || rpeEntry != 0 {
            RepsLabel.text = repsString
        }
        // Assign weight label
        let e1RMInt = Int(e1RMString)!
        let repsInt = Int(repsString)!
        WeightLabel.text = calculateTopSet(e1RM: e1RMInt, weight: weightEntry, reps: repsInt, rpe: Double(rpeEntry))
    }
    
    // get text field value and convert to int
    func getInput(field:UITextField) -> Int{
        let input = field.text!
        return Int(input) ?? 0
    }
    
    // determine the amount of reps for the top set based off the day/week selected
    func calculateReps(day:String, week:String) -> String{
        var reps = ""
        if week == "Week 1" && day == "Day 1" {reps = "6"}
        if week == "Week 2" && day == "Day 1" {reps = "5"}
        if week == "Week 3" && day == "Day 1" {reps = "4"}
        if week == "Week 1" && day == "Day 2" {reps = "3"}
        if week == "Week 2" && day == "Day 2" {reps = "2"}
        if week == "Week 3" && day == "Day 2" {reps = "1"}
        return reps
    }
    
    // calculate the estimated 1RM based off the data entered
    func calculate1RM(weight:Int, reps:Int, rpe:Double) -> String{
        let multiplier:Double = 1.005
        var e1RM:Int = 0
        
        if reps ==  1 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 1) * multiplier))}
        if reps ==  1 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.98) * multiplier))}
        if reps ==  1 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.96) * multiplier))}
        if reps ==  1 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.94) * multiplier))}
        if reps ==  1 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.92) * multiplier))}
        if reps ==  1 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.91) * multiplier))}
        if reps ==  1 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.89) * multiplier))}
        if reps ==  1 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.88) * multiplier))}
        if reps ==  2 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.96) * multiplier))}
        if reps ==  2 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.94) * multiplier))}
        if reps ==  2 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.92) * multiplier))}
        if reps ==  2 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.91) * multiplier))}
        if reps ==  2 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.89) * multiplier))}
        if reps ==  2 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.88) * multiplier))}
        if reps ==  2 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.86) * multiplier))}
        if reps ==  2 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.85) * multiplier))}
        if reps ==  3 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.92) * multiplier))}
        if reps ==  3 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.91) * multiplier))}
        if reps ==  3 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.89) * multiplier))}
        if reps ==  3 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.88) * multiplier))}
        if reps ==  3 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.86) * multiplier))}
        if reps ==  3 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.85) * multiplier))}
        if reps ==  3 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.84) * multiplier))}
        if reps ==  3 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.82) * multiplier))}
        if reps ==  4 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.89) * multiplier))}
        if reps ==  4 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.88) * multiplier))}
        if reps ==  4 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.86) * multiplier))}
        if reps ==  4 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.85) * multiplier))}
        if reps ==  4 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.84) * multiplier))}
        if reps ==  4 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.82) * multiplier))}
        if reps ==  4 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.81) * multiplier))}
        if reps ==  4 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.8) * multiplier))}
        if reps ==  5 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.86) * multiplier))}
        if reps ==  5 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.85) * multiplier))}
        if reps ==  5 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.84) * multiplier))}
        if reps ==  5 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.82) * multiplier))}
        if reps ==  5 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.81) * multiplier))}
        if reps ==  5 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.8) * multiplier))}
        if reps ==  5 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.79) * multiplier))}
        if reps ==  5 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.77) * multiplier))}
        if reps ==  6 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.84) * multiplier))}
        if reps ==  6 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.82) * multiplier))}
        if reps ==  6 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.81) * multiplier))}
        if reps ==  6 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.8) * multiplier))}
        if reps ==  6 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.79) * multiplier))}
        if reps ==  6 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.77) * multiplier))}
        if reps ==  6 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.76) * multiplier))}
        if reps ==  6 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.75) * multiplier))}
        if reps ==  7 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.81) * multiplier))}
        if reps ==  7 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.8) * multiplier))}
        if reps ==  7 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.79) * multiplier))}
        if reps ==  7 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.77) * multiplier))}
        if reps ==  7 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.76) * multiplier))}
        if reps ==  7 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.75) * multiplier))}
        if reps ==  7 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.74) * multiplier))}
        if reps ==  7 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.72) * multiplier))}
        if reps ==  8 && rpe ==  10 {
            e1RM = Int(round((Double(weight) / 0.79) * multiplier))}
        if reps ==  8 && rpe ==  9.5 {
            e1RM = Int(round((Double(weight) / 0.77) * multiplier))}
        if reps ==  8 && rpe ==  9 {
            e1RM = Int(round((Double(weight) / 0.76) * multiplier))}
        if reps ==  8 && rpe ==  8.5 {
            e1RM = Int(round((Double(weight) / 0.75) * multiplier))}
        if reps ==  8 && rpe ==  8 {
            e1RM = Int(round((Double(weight) / 0.74) * multiplier))}
        if reps ==  8 && rpe ==  7.5 {
            e1RM = Int(round((Double(weight) / 0.72) * multiplier))}
        if reps ==  8 && rpe ==  7 {
            e1RM = Int(round((Double(weight) / 0.71) * multiplier))}
        if reps ==  8 && rpe ==  6.5 {
            e1RM = Int(round((Double(weight) / 0.69) * multiplier))}

        return String(e1RM)
    }
    
    func calculateTopSet(e1RM:Int, weight:Int, reps:Int, rpe:Double) -> String {
        let mulitplier:Double = 1.005
        let newWeight = Double(e1RM) * mulitplier
        var topSetWeight:Int = 0
        
        if reps == 6 {
            topSetWeight = Int(round(0.81 * newWeight))}
        if reps == 5 {
            topSetWeight = Int(round(0.84 * newWeight))}
        if reps == 4 {
            topSetWeight = Int(round(0.86 * newWeight))}
        if reps == 3 {
            topSetWeight = Int(round(0.89 * newWeight))}
        if reps == 2 {
            topSetWeight = Int(round(0.92 * newWeight))}
        if reps == 1 {
            topSetWeight = Int(round(0.96 * newWeight))}
        
        return String(topSetWeight)
    }
    
    // hide keyboard/picker when touch even occurs
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

