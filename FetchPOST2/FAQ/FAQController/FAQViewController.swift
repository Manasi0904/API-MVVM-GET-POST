//
//  FAQViewController.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

class FAQViewController: UIViewController {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var FAQLabel: UILabel!
    @IBOutlet var wearehereLabel: UILabel!
    @IBOutlet var searchYourQueryTextField: UITextField!
    @IBOutlet var mycollectionFAQ: UICollectionView!
    @IBOutlet var myFAQTableView: UITableView!
    @IBOutlet var topQuestionsLabel: UILabel!
    
    var faqViewModel = FAQViewModel()
    
    var faqCategories: [FAQCategory] = []
    var faqQuestions: [FAQ] = []
    var isSelectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchFAQCategories()
    }

  func setupUI() {
        FAQLabel.font = UIFont(name: "Circe-Bold", size: 16)
        wearehereLabel.font = UIFont(name: "Circe-Regular", size: 18)
        searchYourQueryTextField.font = UIFont(name: "Circe-Regular", size: 14)
        topQuestionsLabel.font = UIFont(name: "Circe-Regular", size: 16)

        mycollectionFAQ.dataSource = self
        mycollectionFAQ.delegate = self
      //  mycollectionFAQ.allowsSelection = true 
        mycollectionFAQ.register(UINib(nibName: "FAQCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FAQCollectionViewCell")

        myFAQTableView.dataSource = self
        myFAQTableView.delegate = self
        myFAQTableView.register(UINib(nibName: "FAQQuesAnsTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQQuesAnsTableViewCell")
    }

  func fetchFAQCategories() {
        faqViewModel.fetchFAQCategories { [weak self] result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.faqCategories = categories
                    self?.mycollectionFAQ.reloadData()
                    
                    if let firstCategory = categories.first {
                        self?.fetchFAQQuestions(for: firstCategory.faqCategoryId)
                    }
                }
            case .failure(let error):
                print("Error fetching FAQ categories: \(error)")
            }
        }
    }

    func fetchFAQQuestions(for categoryId: Int) {
        faqViewModel.fetchFAQQuestions(for: categoryId) { [weak self] result in
            switch result {
            case .success(let questions):
                DispatchQueue.main.async {
                    self?.faqQuestions = questions
                    self?.myFAQTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching FAQ questions: \(error)")
            }
        }
    }

    @IBAction func backButtontoFAQ(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}


extension FAQViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faqCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FAQCollectionViewCell", for: indexPath) as! FAQCollectionViewCell
        let category = faqCategories[indexPath.row]
        cell.faqCategoryLabel.text = category.faqCategoryTitle
        
        
        if indexPath.row == isSelectedIndex {
            cell.backgroundColor = UIColor.saddleBrown
            cell.faqCategoryLabel.textColor = .white
        } else {
            cell.backgroundColor = UIColor.munsell
            cell.faqCategoryLabel.textColor = .dimGrey
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = faqCategories[indexPath.row]
        isSelectedIndex = indexPath.row
        DispatchQueue.main.async {
            self.mycollectionFAQ.reloadData()
        }
        fetchFAQQuestions(for: selectedCategory.faqCategoryId)
        
    }
}


extension FAQViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqQuestions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQQuesAnsTableViewCell", for: indexPath) as! FAQQuesAnsTableViewCell
        let question = faqQuestions[indexPath.row]
        cell.questionLabel.text = question.question
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
  
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFAQ = faqQuestions[indexPath.row]
            if let answerVC = self.storyboard?.instantiateViewController(withIdentifier: "AnswerViewController") as? AnswerViewController {
                answerVC.selectedFAQ = selectedFAQ 
                self.navigationController?.pushViewController(answerVC, animated: true)
            }
        }
    }


