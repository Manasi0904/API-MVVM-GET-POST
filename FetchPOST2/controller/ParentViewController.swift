//
//  ParentViewController.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

class ParentViewController: UIViewController {
    @IBOutlet var onStoreButton: UIButton!
    @IBOutlet var onFAQButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


                self.navigationController?.isNavigationBarHidden = true
                onStoreButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
                onFAQButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
               
                onStoreButton.layer.cornerRadius = 10
                onFAQButton.layer.cornerRadius = 10
                
              
            }
            
            
    @IBAction func onStoreTappedBTN(_ sender: Any) {
                let Storyboard = self.storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
                self.navigationController?.pushViewController(Storyboard, animated: true)
            }
            
            

    @IBAction func onFAQTappedBTN(_ sender: Any) {
        
        let Storyboard = self.storyboard?.instantiateViewController(identifier: "FAQViewController") as! FAQViewController
        self.navigationController?.pushViewController(Storyboard, animated: true)
    }
    
    
    
        }

