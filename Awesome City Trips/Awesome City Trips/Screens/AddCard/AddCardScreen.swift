//
//  AddCardScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 12/2/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import KVNProgress

class AddCardScreen: UIViewController {
    
    @IBOutlet weak var textfieldNumber: UITextField!
    @IBOutlet weak var textfieldExpirationDate: UITextField!
    @IBOutlet weak var textfieldCVV: UITextField!
    
    let creditCardIcon = "http://icons.iconarchive.com/icons/designbolts/credit-card-payment/256/Master-Card-Blue-icon.png"
    
    @IBAction func onTapCreate(_ sender: UIButton, forEvent event: UIEvent) {
        
        guard let user = Workspace.shared.currentUser else {
            self.showSimpleAlert(message: .errorLoginNoData)
            return
        }
        
        guard let number = textfieldNumber.text,
            let date = textfieldExpirationDate.text,
            let cvv = textfieldCVV.text,
            number.count > 10, date.count > 0, cvv.count > 0 else {
                
            self.showSimpleAlert(message: .errorLoginNoData)
            return
        }
        
        let startIndex = number.index(number.startIndex, offsetBy: 6)
        let endIndex = number.index(number.endIndex, offsetBy: -4)
        
        let input = InputAddCardToUser(
            token: user.token,
            firstSixDigits: String(number.prefix(upTo: startIndex)),
            issuerIconUrl: creditCardIcon,
            lastFourDigits: String(number.suffix(from: endIndex)))
        
        KVNProgress.show()
        RequestAddCardToUser.request(input: input) { [weak self] response in
            
            KVNProgress.dismiss()
            
            guard let `self` = self else { return }
            
            switch response {
                
            case .success(let output):
                self.navigationController?.popViewController(animated: true)
                return
                
            default:
                self.showSimpleAlert(message: .errorOnFetchingData)
                return
            }
        }
    }
}
