//
//  CreditCardsScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/23/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import KVNProgress

class CreditCardsScreen: UIViewController {
    
    @IBOutlet weak private var table: UITableView!
    
    private var allCreditCards: [CreditCard] = []
}

extension CreditCardsScreen {
    
    override func viewDidLoad() {

        // TODO: Temporal
        Workspace.shared.currentUser = User(
            id: 0,
            lastName: "Saenz",
            firstName: "Rigoberto",
            pictureUrl: "https://avatars3.githubusercontent.com/u/2594928?s=460&v=4",
            email: "beto456789@gmail.com",
            birthday: "03/05/1988",
            username: "rsaenzi",
            password: "qwerty",
            lastAccess: Date(),
            creditCard: [],
            buyedEvents: [])
        // TODO: Temporal
        
        guard let currentUser = Workspace.shared.currentUser else {
            self.showSimpleAlert(message: .errorNoCurrentUser)
            return
        }
        
        KVNProgress.show()
        
        RequestGetCreditCardsFromUser.request(userId: currentUser.id) { [weak self] response in
            
            KVNProgress.dismiss()
            
            guard let `self` = self else { return }
            
            switch response {
            case .success(let output):
                self.allCreditCards = output.creditCards
                
            default:
                self.allCreditCards = []
                self.showSimpleAlert(message: .errorOnFetchingData)
            }
            
            self.table.reloadData()
            
        }
    }
}

extension CreditCardsScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCreditCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let creditCard = allCreditCards[indexPath.row]
        
        let cell: CreditCardsCell = tableView.dequeue(indexPath)
        cell.fill(using: creditCard)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let creditCard = allCreditCards[indexPath.row]
        
        // TODO: Continuar el proceso de pago...
    }
}
