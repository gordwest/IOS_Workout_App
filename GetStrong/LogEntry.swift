//
//  ExerciseSet.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-24.
//  Copyright © 2020 Gord West. All rights reserved.
//

import Foundation

class LogEntry: Codable {
    var date: String
    var exercise: String
    var weight: String
    var reps: String
    var rpe: String
    
    init(date: String, exercise: String, weight: String, reps: String, rpe: String) {
        self.date = date
        self.exercise = exercise
        self.weight = weight
        self.reps = reps
        self.rpe = rpe
    }
    
}
