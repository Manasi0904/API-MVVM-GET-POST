//
//  FAQContactViewController.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 19/12/24.
//
/*
import UIKit

class FAQContactViewController: UIViewController {

    @IBOutlet var writeToUsLbl: UILabel!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var mobileNumberTextField: UITextField!
    @IBOutlet var UserMobileTextField: UITextField!
    @IBOutlet var EmailtextField: UITextField!
    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var youCanAlsoLbl: UILabel!
    @IBOutlet var callButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
       nameView.layer .cornerRadius = 10
       nameView.layer.borderWidth = 1
       nameView.layer.borderColor = UIColor.platinum.cgColor
       nameTextField.font = UIFont(name:"Circe-Regular", size: 12)
       userNameTextField.font = UIFont(name:"Circe-Regular", size: 15)
       mobileNumberTextField.font = UIFont(name:"Circe-Regular", size: 12)
       UserMobileTextField.font = UIFont(name:"Circe-Regular", size: 15)
       EmailtextField.font = UIFont(name:"Circe-Regular", size: 12)
       userEmailTextField.font = UIFont(name:"Circe-Regular", size: 15)
       messageTextField.font = UIFont(name:"Circe-Regular", size: 12)
       messageTextField.layer.cornerRadius = 8
        submitButton.layer.cornerRadius = 5
       submitButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
       youCanAlsoLbl.font = UIFont(name:"Circe-Regular", size: 18)
       callButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
       callButton.layer.cornerRadius = 10
       callButton.layer.borderWidth = 1
       callButton.layer.borderColor = UIColor.copper.cgColor
        
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    @IBAction func callButton(_ sender: Any) {
    }
}

*/

import UIKit

class FAQContactViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var writeToUsLbl: UILabel!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var mobileNumberTextField: UITextField!
    @IBOutlet var UserMobileTextField: UITextField!
    @IBOutlet var EmailtextField: UITextField!
    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var youCanAlsoLbl: UILabel!
    @IBOutlet var callButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        nameView.layer.cornerRadius = 10
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.font = UIFont(name: "Circe-Regular", size: 12)
        userNameTextField.font = UIFont(name: "Circe-Regular", size: 15)
        mobileNumberTextField.font = UIFont(name: "Circe-Regular", size: 12)
        UserMobileTextField.font = UIFont(name: "Circe-Regular", size: 15)
        EmailtextField.font = UIFont(name: "Circe-Regular", size: 12)
        userEmailTextField.font = UIFont(name: "Circe-Regular", size: 15)
        messageTextField.font = UIFont(name: "Circe-Regular", size: 12)
        messageTextField.layer.cornerRadius = 8
        submitButton.layer.cornerRadius = 5
        submitButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 14)
        youCanAlsoLbl.font = UIFont(name: "Circe-Regular", size: 18)
        callButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
        callButton.layer.cornerRadius = 10
        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor.systemOrange.cgColor
        
        
        userNameTextField.delegate = self
        UserMobileTextField.delegate = self
        userEmailTextField.delegate = self
        
      
        updateSubmitButtonState()
        
      
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - TextField Validation
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameTextField {
           
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        } else if textField == UserMobileTextField {
           
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            
           
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 10
        } else if textField == userEmailTextField {
           
            return true
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSubmitButtonState()
    }
    
   
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[a-zA-Z]+[0-9]*@[a-zA-Z]+\\.[a-z]{2,64}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
  
    func updateSubmitButtonState() {
        let isNameValid = !(userNameTextField.text?.isEmpty ?? true)
        let isPhoneValid = UserMobileTextField.text?.count == 10
        let isEmailValid = isValidEmail(userEmailTextField.text ?? "")
        
        let shouldEnableSubmit = isNameValid && isPhoneValid && isEmailValid
        submitButton.isEnabled = shouldEnableSubmit
        submitButton.alpha = shouldEnableSubmit ? 1.0 : 0.5
    }
    
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
    }
    
    @IBAction func callButton(_ sender: Any) {
      
    }
}
