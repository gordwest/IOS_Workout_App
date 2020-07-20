//
//  HistoryViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, InputFormViewControllerDelegate {
    
    // MARK: Variables
    var logEntries: [LogEntry] = []
    
    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: View Lifecyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        logEntries = load() // load existing data
        print("Loaded")
    }
    
    // add new log entry to array and reload table data
    func addNewExerciseEntry(logEntry: LogEntry) {
        logEntries.append(logEntry)
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
    
    // call save method when leaving the table view screen
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
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let logEntry = logEntries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogEntryCell") as! LogEntryCell
        cell.setLogEntry(logEntry: logEntry)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            logEntries.remove(at: indexPath.row)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
}



    
    
    
    
