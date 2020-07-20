//
//  MainMenuViewController.swift
//  GetStrong
//
//  Created by Gord West on 2020-06-23.
//  Copyright © 2020 Gord West. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Animates the navigation bar back to top when next VC is pushed
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    // Hides the navigation bar on the first VC only
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}
