//
//  Colors.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

enum Colors {
    case darkBlue
}

extension Colors {
    
    func color() -> UIColor {
        switch self {
        case .darkBlue:
            return #colorLiteral(red: 0.1529411765, green: 0.3098039216, blue: 0.4078431373, alpha: 1)
        }
    }
}
