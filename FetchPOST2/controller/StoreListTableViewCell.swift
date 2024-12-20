//
//  StoreListTableViewCell.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 10/12/24.
//

import UIKit
class StoreListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var StoreImage: UIImageView!
    @IBOutlet weak var storeNameLbl: UILabel!
    @IBOutlet weak var StoreAddress: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    private func setupUI() {

       

        StoreImage.layer.cornerRadius = 10
        StoreImage.clipsToBounds = true
        storeNameLbl.font = UIFont(name: "Circe-Bold", size: 14)
        StoreAddress.font = UIFont(name: "Circe-Light", size: 12)
        timerLabel.font = UIFont(name: "Circe-Regular", size: 10)
        contentview?.layer.cornerRadius = 10
        
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.platinum.cgColor
        cardView.layer.cornerRadius = 10
    }



    func configure(with viewModel: StoreViewModel) {
        storeNameLbl?.text = viewModel.storeName
        StoreAddress?.text = viewModel.storeAddress
        timerLabel?.text = viewModel.businessHours

        DispatchQueue.global().async {
            if let url = viewModel.storeImagePath,
               let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.StoreImage?.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.StoreImage?.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}
