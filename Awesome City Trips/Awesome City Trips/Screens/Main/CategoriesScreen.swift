//
//  CategoriesScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/21/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

class CategoriesScreen: UIViewController {
    
    private var allCategories: [Category] = []
    
    override func viewDidLoad() {
        
        allCategories = [
            Category(type: .business),
            Category(type: .gastronomy),
            Category(type: .history),
            Category(type: .nature),
            Category(type: .party),
            Category(type: .study),
            Category(type: .surgery),
        ]
    }
}


extension CategoriesScreen: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = allCategories[indexPath.row]
        
        let cell: CategoryCell = tableView.dequeue(indexPath)
        cell.categoryName.text = category.type.getName()
        cell.categoryImage.image = category.type.getIcon()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let screen: AvailablePlansScreen = loadViewController()
        navigationController?.pushViewController(screen, animated: true)
    }
}
