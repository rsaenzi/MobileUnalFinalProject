//
//  CategoryCell.swift
//  Awesome City Trips
//
//  Created by Rigoberto Saenz on 8/21/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak private var categoryImage: UIImageView!
    @IBOutlet weak private var categoryName: UILabel!
    
    func fill(using category: Category) {
        
        categoryName.text = category.name
        
        guard let imageUrl: URL = URL(string: category.bannerUrl) else {
            categoryImage.image = nil
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
        
        let image = ImageResource(downloadURL: imageUrl, cacheKey: "category\(category.id)")
        categoryImage.kf.indicatorType = .activity
        categoryImage.kf.setImage(
            with: image,
            placeholder: nil,
            options: [.transition(.fade(0.2))],
            progressBlock: nil,
            completionHandler: completion)
    }
}
