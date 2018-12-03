//
//  MyEventsScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import KVNProgress

class MyEventsScreen: UIViewController {
    
    @IBOutlet weak private var table: UITableView!
    
    private var allEvents: [Event] = []
}

extension MyEventsScreen {
    
    override func viewDidLoad() {
        
        guard let currentUser = Workspace.shared.currentUser else {
            self.showSimpleAlert(message: .errorNoCurrentUser)
            return
        }
        
        KVNProgress.show()
        
        RequestGetEventsBuyedByUser.request(userId: currentUser.token) { [weak self] response in
            
            KVNProgress.dismiss()
            
            guard let `self` = self else { return }
            
            switch response {
            case .success(let output):
                self.allEvents = output.events
                
            default:
                self.allEvents = []
                self.showSimpleAlert(message: .errorOnFetchingData)
            }
            
            self.table.reloadData()
            
        }
    }
}

extension MyEventsScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = allEvents[indexPath.row]
        
        let cell: MyEventsCell = tableView.dequeue(indexPath)
        cell.fill(using: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let event = allEvents[indexPath.row]
        
        let screen: EventDetailsScreen = loadViewController()
        screen.setup(using: event)
        navigationController?.pushViewController(screen, animated: true)
    }
}
