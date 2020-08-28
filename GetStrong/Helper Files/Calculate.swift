//
//  Calculate.swift
//  GetStrong
//
//  Created by Gord West on 2020-08-27.
//  Copyright © 2020 Gord West. All rights reserved.
//

import Foundation

struct Calculate {
    
    // determine the amount of reps for the top set based off the day/week selected
    static func getReps(day:String, week:String) -> Int{
        var reps = 0
        if week == "Week 1" && day == "Day 1" {reps = 6}
        if week == "Week 2" && day == "Day 1" {reps = 5}
        if week == "Week 3" && day == "Day 1" {reps = 4}
        if week == "Week 1" && day == "Day 2" {reps = 3}
        if week == "Week 2" && day == "Day 2" {reps = 2}
        if week == "Week 3" && day == "Day 2" {reps = 1}
        return reps
    }
    
    static func getTopSet(e1RM:Int, weight:Int, reps:Int, rpe:Double) -> String {
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
    
    // calculate the estimated 1RM based off the data entered
    static func getE1RM(weight:Int, reps:Int, rpe:Double) -> Int{
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

        return e1RM
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
    
}
