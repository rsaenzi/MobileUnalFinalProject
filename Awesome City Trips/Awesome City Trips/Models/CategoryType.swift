//
//  CategoryType.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

enum CategoryType {
    case business
    case gastronomy
    case history
    case nature
    case party
    case study
    case surgery
    
    func getName() -> String {
        switch self {
        case .business: return "Business"
        case .gastronomy: return "Gastronomy"
        case .history: return "History"
        case .nature: return "Nature"
        case .party: return "Party"
        case .study: return "Study"
        case .surgery: return "Surgery"
        }
    }
    
    func getIcon() -> UIImage {
        switch self {
        case .business: return #imageLiteral(resourceName: "CategoryBusiness")
        case .gastronomy: return #imageLiteral(resourceName: "CategoryGastronomy")
        case .history: return #imageLiteral(resourceName: "CategoryHistory")
        case .nature: return #imageLiteral(resourceName: "CategoryNature")
        case .party: return #imageLiteral(resourceName: "CategoryParty")
        case .study: return #imageLiteral(resourceName: "CategoryStudy")
        case .surgery: return #imageLiteral(resourceName: "CategorySurgery")
        }
    }
}
