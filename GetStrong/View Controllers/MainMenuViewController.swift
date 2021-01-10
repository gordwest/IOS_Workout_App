//
//  MainMenuViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var ExerciseLabel: UILabel!
    @IBOutlet weak var bestLiftLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    let HistoryVC = HistoryViewController()
    
    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let myLogEntries = HistoryVC.load()
        
        let bestLiftInfo = getBestLift(logEntries: myLogEntries)
        
        if (bestLiftInfo.count > 1) {
            bestLiftLabel.text = bestLiftInfo[1] + " lbs for " + bestLiftInfo[2]
            ExerciseLabel.text = bestLiftInfo[0]
            dateLabel.text = bestLiftInfo[3]
            bestLiftLabel.textColor = UIColor.white
            ExerciseLabel.textColor = UIColor.white
            dateLabel.textColor = UIColor.white
        }
        else {
            bestLiftLabel.text = ""
            ExerciseLabel.text = ""
            dateLabel.textColor = UIColor.systemRed
            dateLabel.text = bestLiftInfo[0]
        }
    }
    
    func getBestLift(logEntries: Array<LogEntry>) -> Array<String>{
        if (logEntries.count > 0) {
            // return best lift
            let bestLift = logEntries.max { $0.weight < $1.weight }
            let bestLift_weight = String(bestLift!.weight)
            let bestLift_exercise = bestLift!.exercise
            let bestLift_reps = String(bestLift!.reps)
            let bestLift_date = bestLift!.date
            
            return [bestLift_exercise, bestLift_weight, bestLift_reps, bestLift_date]
        }
        else {
            return ["No data"]
        }
    }
    
}
