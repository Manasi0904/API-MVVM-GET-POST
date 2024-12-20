//
//  CustomDetailUIView.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 19/12/24.
//
   




import UIKit

class CustomDetailUIView: UIView {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var popUpview: UIView!
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeStatus: UILabel!
    @IBOutlet weak var storeTiming: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var amenitiesLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet var directionButton: UIButton!
    @IBOutlet var menuButton: UIButton!
   

        var storeViewModel: StoreViewModel?{

            didSet {

                setupView()

                self.collectionview.delegate = self

                self.collectionview.dataSource = self

               
                storeTitle.font = UIFont(name: "Circe-Bold", size: 20)
                storeTiming.font = UIFont(name: "Circe-Bold", size: 12)
                storeStatus.font = UIFont(name: "Circe-Regular", size: 12)
                amenitiesLabel.font = UIFont(name: "Circe-Bold", size: 16)
                storeImage.layer.cornerRadius = 14
                detailsLabel.font = UIFont(name: "Circe-Bold", size: 17)
                storeAddress.font = UIFont(name: "Circe-Regular", size: 15)
                contactPhoneLabel.font = UIFont(name: "Circe-Regular", size: 15)
                contactEmailLabel.font = UIFont(name: "Circe-Regular", size: 15)
                directionButton.layer.cornerRadius = 14
                directionButton.layer.borderWidth = 1.0
                directionButton.layer.borderColor = UIColor.saddleBrown.cgColor
                menuButton.layer.cornerRadius = 10
                popUpview.layer.cornerRadius = 14

            }
        }
        override init (frame: CGRect) {
            super.init(frame: frame)
            initialSetUp()
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            initialSetUp()
        }
    

    private func initialSetUp() {
        guard let loadedView = Bundle.main.loadNibNamed("CustomDetailUIView", owner: self, options: nil)?.first as? UIView else {
            print("Error: Could not load CustomDetailUIView.xib")
            return
        }
        self.addSubview(loadedView)
        loadedView.frame = self.bounds
        loadedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView = loadedView

       

        collectionview.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        contentView.addGestureRecognizer(tapGesture)
    }

        func setupView() {
            guard let viewModel = storeViewModel else {
                print("Error: storeViewModel is nil")
                return
            }
            storeImage.layer.cornerRadius = 14
            popUpview.layer.cornerRadius = 14
            popUpview.clipsToBounds = true
            popUpview.backgroundColor = UIColor.white
            storeTitle.text = viewModel.storeName
            let time = viewModel.businessHours
            let parts = time!.components(separatedBy: ": ")
            if parts.count > 1 {
                print(parts[1])
            } else {
                print("Time not found in the string")
            }
            storeTiming.text = parts[1]
            contactPhoneLabel.text = viewModel.contactPhoneNumber
            contactEmailLabel.text = viewModel.contactEmail
            storeAddress.text = viewModel.storeAddress
            if let imageUrl = viewModel.storeImagePath {
                loadImage(from: imageUrl)
            } else {
                storeImage.image = UIImage(systemName: "photo")
            }
        }
        private func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self,
                      let data = data,
                      error == nil,
                      let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self?.storeImage.image = UIImage(systemName: "photo")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.storeImage.image = image
                }
            }.resume()
        }
        @objc func dismissPopUp() {
                self.removeFromSuperview()
            }
    }
    extension CustomDetailUIView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return storeViewModel?.amenities.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            let amenity = storeViewModel?.amenities[indexPath.item]
            cell.amenitiesLabel.text = amenity?.amenityTitle
                if let imagePath = amenity?.imagePath, let url = URL(string: imagePath) {
                    FetchPOST2.loadImage(from: url, for: cell)
                } else {
                    cell.amenitiesImage.image = UIImage(systemName: "photo")
                }
                return cell
        }
    }
    private func loadImage(from url: URL, for cell: CollectionViewCell) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.amenitiesImage.image = image
                }
            } else {
                DispatchQueue.main.async {
                    cell.amenitiesImage.image = UIImage(systemName: "photo")
                }
            }
        }.resume()
    }
