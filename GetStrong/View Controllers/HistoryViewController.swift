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
    
    // add new log entry to array and reload table data
    func addNewExerciseEntry(logEntry: LogEntry) {
        logEntries.insert(logEntry, at: 0)
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
        print(filteredData[indexPath.row].exercise)
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
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let calculate = UITableViewRowAction(style: .normal, title: "Calculate") { (action, indexPath) in
            print("Calculate")
        }
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            print("Deleted")
        }
        return [delete, calculate]
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, boolValue) in
            print("Editing")
        }
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if dataIndex == nil {
                filteredData.remove(at: indexPath.row)
                logEntries.remove(at: indexPath.row)
            }
            else {
                filteredData.remove(at: indexPath.row)
                logEntries.remove(at: dataIndex[indexPath.row]) //pass in index from original array
            }
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    } */
}



    
    
    
    
