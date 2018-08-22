//
//  HomeScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/21/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit

class HomeViewScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeCategoryCell = tableView.dequeue(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func viewDidLoad() {
        print("View did load");
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("View did appear")
    }
}
