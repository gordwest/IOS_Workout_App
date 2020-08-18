//
//  Alert.swift
//  GetStrong
//
//  Created by Gord West on 2020-08-17.
//  Copyright © 2020 Gord West. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert,  animated: true)
    }
}
