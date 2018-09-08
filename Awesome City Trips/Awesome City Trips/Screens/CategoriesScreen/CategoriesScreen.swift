//
//  CategoriesScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/21/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import KVNProgress

class CategoriesScreen: UIViewController {
    
    @IBOutlet weak private var table: UITableView!
    
    private var allCategories: [Category] = []
}

extension CategoriesScreen {
    
    override func viewDidLoad() {
        
        KVNProgress.show()
        
        RequestGetCategories.request { [weak self] response in
            
            KVNProgress.dismiss()
            
            guard let `self` = self else { return }
            
            switch response {
            case .success(let output):
                self.allCategories = output.categories
                
            default:
                self.allCategories = []
                self.showSimpleAlert(message: .errorOnFetchingData)
            }
            
            self.table.reloadData()
        }
    }
}


extension CategoriesScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = allCategories[indexPath.row]
        
        let cell: CategoryCell = tableView.dequeue(indexPath)
        cell.fill(using: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = allCategories[indexPath.row]
        
        let screen: AvailableEventsScreen = loadViewController()
        screen.setup(category)
        navigationController?.pushViewController(screen, animated: true)
    }
}

