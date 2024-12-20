//
//  CollectionViewCell.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 16/12/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var amenitiesImage: UIImageView!
    @IBOutlet var amenitiesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        amenitiesLabel.font = UIFont(name:"Circe-Regular", size: 10)
        amenitiesImage.layer.cornerRadius = 8
    }

}
