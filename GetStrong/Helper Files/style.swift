//
//  style.swift
//  GetStrong
//
//  Created by Gord West on 2021-01-09.
//  Copyright © 2021 Gord West. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
