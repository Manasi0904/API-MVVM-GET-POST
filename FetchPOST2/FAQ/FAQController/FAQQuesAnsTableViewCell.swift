//
//  FAQQuesAnsTableViewCell.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

class FAQQuesAnsTableViewCell: UITableViewCell {

    @IBOutlet var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        questionLabel.font = UIFont(name:"Circe-Regular", size: 14)
    }
    
}
