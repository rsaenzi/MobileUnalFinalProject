//
//  PlanDetailsScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/23/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

class PlanDetailsScreen: UIViewController {
    
    
    @IBAction func onTapBuy(_ sender: UIButton, forEvent event: UIEvent) {
        
        let screen: CreditCardsScreen = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}
