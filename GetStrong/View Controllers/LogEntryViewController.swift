//
//  HistoryViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

// initialize global var for log entries
var logEntries: [LogEntry] = []

class LogEntryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        print("Loaded")
        logEntries = load() // load existing data
    }
    
    @IBAction func addRowClick(_ sender: Any) {
        insertNewLogEntry()
    }
    
    // call save method when leaving the table view screen
    override func viewWillDisappear(_ animated: Bool) {
        print(String(describing: save(data: logEntries)))
    }
    
    // insert a new row into table view on Entry Log screen
    func insertNewLogEntry(){
        // hard coded new row entry
        let logEntry = LogEntry(date: currentDate(), weight: "405", reps: "4", rpe: "9")
        logEntries.append(logEntry)
        let indexPath = IndexPath(row: logEntries.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    // return current date as a string
    func currentDate() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    // load user default table data or initialize new empty array
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
}

extension LogEntryViewController: UITableViewDelegate, UITableViewDataSource{
    
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



    
    
    
    
