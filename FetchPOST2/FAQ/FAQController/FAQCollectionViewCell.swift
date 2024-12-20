//
//  FAQCollectionViewCell.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

class FAQCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet var faqCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
       
        faqCategoryLabel.font = UIFont(name: "Circe-Regular", size: 14)
        
        
        self.backgroundColor = UIColor.clear
    }

    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = UIColor.saddleBrown
                
            } else {
                self.backgroundColor = UIColor.munsell
            }
        }
    }
}
