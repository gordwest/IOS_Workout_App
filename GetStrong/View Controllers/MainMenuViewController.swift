//
//  MainMenuViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToCalculator() {
        let vc = storyboard?.instantiateViewController(identifier: "calculatorVC") as! CalculatorViewController
        present(vc, animated: true)
    }
    
    @IBAction func goToHistory(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "historyVC") as! HistoryViewController
        present(vc, animated: true)
    }
    
    @IBAction func goToAbout() {
        let vc = storyboard?.instantiateViewController(identifier: "aboutVC") as! AboutViewController
        present(vc, animated: true)
    }
}
