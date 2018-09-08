//
//  CreditCardsScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/23/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

class CreditCardsScreen: UIViewController {
    
}

extension CreditCardsScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let category = allCategories[indexPath.row]
        
        let cell: CreditCardsCell = tableView.dequeue(indexPath)
        //        cell.categoryName.text = category.type.getName()
        //        cell.categoryImage.image = category.type.getIcon()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let screen: EventDetailsScreen = loadViewController()
//        navigationController?.pushViewController(screen, animated: true)
    }
}
