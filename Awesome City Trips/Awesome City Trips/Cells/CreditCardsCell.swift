//
//  CreditCardsCell.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/23/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import Kingfisher

class CreditCardsCell: UITableViewCell {
    
    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    
    func fill(using creditCard: CreditCard) {
        
        cardNumber.text = "XXXX XXXX XXXX \(creditCard.lastFourDigits)"
        
        guard let imageUrl: URL = URL(string: creditCard.issuerIconUrl) else {
            cardIcon.image = nil
            return
        }
        
        let completion: CompletionHandler = {
            (image, error, cacheType, imageUrl) in
            
            guard let url = imageUrl else {
                print("Invalid image URL")
                return
            }
            guard let _ = image else {
                print("\(url) can not be loaded...")
                return
            }
            if let _ = error {
                print("\(url) loaded with error...")
                return
            }
        }
        
        //let image = ImageResource(downloadURL: imageUrl, cacheKey: "card\(creditCard.id)")
        
        let image = ImageResource(downloadURL: imageUrl)
        cardIcon.kf.indicatorType = .activity
        cardIcon.kf.setImage(
            with: image,
            placeholder: nil,
            options: [.transition(.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }
}
