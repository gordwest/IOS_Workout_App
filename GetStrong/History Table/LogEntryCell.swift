//
//  LogEntryCell.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-24.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class LogEntryCell: UITableViewCell {


    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var rpeLabel: UILabel!
    
    func setLogEntry(logEntry: LogEntry) {
        dateLabel.text = logEntry.date
        exerciseLabel.text = logEntry.exercise
        weightLabel.text = String(logEntry.weight)
        repsLabel.text = String(logEntry.reps)
        rpeLabel.text = logEntry.rpe
    }
    
}
