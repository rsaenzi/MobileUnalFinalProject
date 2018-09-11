//
//  MyEventsCell.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/22/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import Kingfisher

class MyEventsCell: UITableViewCell {
    
    @IBOutlet weak private var eventIcon: UIImageView!
    @IBOutlet weak private var eventName: UILabel!
    @IBOutlet weak private var eventDate: UILabel!
    @IBOutlet weak private var eventPlace: UILabel!
    
    func fill(using event: Event) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM d, yyyy"
        
        eventName.text = event.name
        eventDate.text = dateFormat.string(from: event.date)
        eventPlace.text = event.place.name
        
        guard let imageUrl: URL = URL(string: event.iconUrl) else {
            eventIcon.image = nil
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
        
        let image = ImageResource(downloadURL: imageUrl, cacheKey: "event\(event.id)")
        eventIcon.kf.indicatorType = .activity
        eventIcon.kf.setImage(
            with: image,
            placeholder: nil,
            options: [.transition(.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }

}
