//
//  HistoryViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UISearchBarDelegate, InputFormViewControllerDelegate {
    
    // MARK: Variables
    var logEntries: [LogEntry] = []
    var filteredData: [LogEntry]!
    var dataIndex: [Int]!
    
    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: View Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        logEntries = load() // load existing data
        print("loaded")
        filteredData = logEntries
    }
    
    // return log entries (for use in other VC)
    func getLogEntries() -> Array<LogEntry> {
        return logEntries
    }
    
    // convert string to date
    func asDate(date:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        return formatter.date(from: date as String)!
    }
    
    // add new log entry to array and reload table data
    func addNewLogEntry(logEntry: LogEntry) {
        logEntries.insert(logEntry, at: 0)
        logEntries = logEntries.sorted(by: {asDate(date: $0.date) > asDate(date: $1.date)}) // sort array by date
        filteredData = logEntries
        tableView.reloadData()
    }
    
    // load user defaults data if exists, or initialize new empty array
    func load() -> [LogEntry]{
        let initializedTable: [LogEntry] = []
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "data") {
            do {
                return try decoder.decode(Array<LogEntry>.self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return initializedTable
    }
    
    // save table data to user defaults
    func save(data: [LogEntry]) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            UserDefaults.standard.set(encoded, forKey: "data")
            return true
        }
        return false
    }
    
    // call save method when leaving the tableview screen
    override func viewWillDisappear(_ animated: Bool) {
        print(String(describing: save(data: logEntries)))
    }

    // MARK: Navigation methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inputFormSegue" {
            let destinationVC = segue.destination as! InputFormViewController
            destinationVC.delegate = self
        }
    }
    
    // MARK: Search Bar config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        dataIndex = []
        if searchText == "" {
            filteredData = logEntries
        }
        else {
            for entry in logEntries {
                if entry.exercise.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(entry)
                    dataIndex.append(logEntries.firstIndex{$0 === entry}!)
                }
            }
        }
        //print(dataIndex)
        self.tableView.reloadData()
    }
}

// MARK: Tableview config
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    // testing cell selection functionality
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let logEntry = filteredData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryCell") as! LogEntryCell
        cell.setLogEntry(logEntry: logEntry)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // create swipe to delete option
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let alertMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
            // create ok button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                // check if data is being filtered and then delete accordingly
                if self.dataIndex == nil {
                       self.filteredData.remove(at: indexPath.row)
                       self.logEntries.remove(at: indexPath.row)
                   }
                   else {
                       self.filteredData.remove(at: indexPath.row)
                       self.logEntries.remove(at: self.dataIndex[indexPath.row]) //pass in index from original array
                   }
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            })
            // create cancel button with action handlder
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                print("Cancel button tapped")
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            // add buttons and present
            alertMessage.addAction(cancel)
            alertMessage.addAction(ok)
            self.present(alertMessage, animated: true, completion: nil)
        }
        // create swipe to populate calculator with log entry data
        let calculate = UIContextualAction(style: .normal, title: "Calculate") {  (contextualAction, view, boolValue) in
            let calculatorView = self.storyboard?.instantiateViewController(withIdentifier: "calculatorVC") as! CalculatorViewController
            self.navigationController?.pushViewController(calculatorView, animated: true)
            calculatorView.weight = String(self.filteredData[indexPath.row].weight)
            calculatorView.reps = String(self.filteredData[indexPath.row].reps)
            calculatorView.rpe = self.filteredData[indexPath.row].rpe
        }
        /*let edit = UIContextualAction(style: .destructive, title: "edit") {  (contextualAction, view, boolValue) in
            //Code I want to do here
        }*/
        
        // modify style of swipe actions
        calculate.backgroundColor = .init(red: 0/255, green: 85/255, blue: 152/255, alpha: 100)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete, calculate])
        return swipeActions
    }
}



    
    
    
    
