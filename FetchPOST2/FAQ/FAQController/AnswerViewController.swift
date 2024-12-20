//
//  AnswerViewController.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 18/12/24.
//
//
import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet var answerFAQLbl: UILabel!
    @IBOutlet var placeDeliveryLbl: UILabel!
    @IBOutlet var answerTextView: UITextView!
   // @IBOutlet var answerLbl: UILabel!
    @IBOutlet var wasThisHelpfulLbl: UILabel!
    @IBOutlet weak var goodFeedbackButton: UIButton!
    @IBOutlet weak var badFeedbackButton: UIButton!
    
    @IBOutlet var stillNotResolvedLbl: UILabel!
    @IBOutlet var contactUsButton: UIButton!
    var selectedFAQ: FAQ?
    var isFeedbackHelpful: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerFAQLbl.font = UIFont(name:"Circe-Bold", size: 16)
        placeDeliveryLbl.font = UIFont(name:"Circe-Regular", size: 18)
        answerTextView.font = UIFont(name:"Circe-Regular", size: 14)
        wasThisHelpfulLbl.font = UIFont(name:"Circe-Regular", size: 14)
        stillNotResolvedLbl.font = UIFont(name:"Circe-Regular", size: 14)
        contactUsButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 12)
        
        
        let contactUsText = "Contact Us"
        let attributedString = NSMutableAttributedString(string: contactUsText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: contactUsText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.saddleBrown, range: NSRange(location: 0, length: contactUsText.count))
        contactUsButton.setAttributedTitle(attributedString, for: .normal)
        
        if let faq = selectedFAQ {
            answerTextView.text = faq.answer
        }
    }
    
    @IBAction func backAnswerButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func contactUsButton(_ sender: Any) {
        let Storyboard = self.storyboard?.instantiateViewController(identifier: "FAQContactViewController") as! FAQContactViewController
        self.navigationController?.pushViewController(Storyboard, animated: true)
    }
    
    
    @IBAction func goodFeedbackButtonTapped(_ sender: UIButton) {
    
        goodFeedbackButton.tintColor = UIColor.green
        badFeedbackButton.tintColor = UIColor.dimGrey
        
        isFeedbackHelpful = true
        print("Feedback: Good")
        submitFeedback()
    }
    

    @IBAction func badFeedbackButtonTapped(_ sender: UIButton) {
       
        badFeedbackButton.tintColor = UIColor.red
        goodFeedbackButton.tintColor = UIColor.dimGrey
        
        isFeedbackHelpful = false
        print("Feedback: Bad")
        submitFeedback()
    }
    
   
    func submitFeedback() {
        guard let faq = selectedFAQ, let isHelpful = isFeedbackHelpful else {
            print("No FAQ or feedback selected")
            return
        }

        ApiService.shared.submitFAQSurvey(isHelpful: isHelpful, faqId: faq.faqId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Thank you for your feedback!")
                case .failure(let error):
                    print("Error submitting feedback: \(error.localizedDescription)")
                }
               // self.enableButtons()
            }
        }
    }
    
 
    func disableButtons() {
        goodFeedbackButton.isEnabled = false
        badFeedbackButton.isEnabled = false
    }
    
   
    func enableButtons() {
        goodFeedbackButton.isEnabled = true
        badFeedbackButton.isEnabled = true
    }
}




