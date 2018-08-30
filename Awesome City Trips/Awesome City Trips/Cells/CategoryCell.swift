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
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    func fill(using category: Category) {
        categoryName.text = category.name
//        categoryImage.image = category.type.getIcon()
    }
}
