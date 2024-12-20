//
//  FAQviewmodel.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

    class FAQViewModel {
        
        private var faqCategories: [FAQCategory] = []
        private var faqQuestions: [FAQ] = []

      
        func fetchFAQCategories(completion: @escaping (Result<[FAQCategory], Error>) -> Void) {
            ApiService.shared.fetchFAQCategories { result in
               switch result {
              case .success(let categories):
                  self.faqCategories = categories
                    completion(.success(categories))
               case .failure(let error):
                   completion(.failure(error))
               }
            }
        }

        
        func fetchFAQQuestions(for categoryId: Int, completion: @escaping (Result<[FAQ], Error>) -> Void) {
            ApiService.shared.fetchFAQQuestions(for: categoryId) { result in
                switch result {
                case .success(let questions):
                    self.faqQuestions = questions
                    completion(.success(questions))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

       
        func getFAQCategories() -> [FAQCategory] {
            return faqCategories
        }

       
        func getFAQQuestions() -> [FAQ] {
            return faqQuestions
        }
        
        
        
        
        func submitFAQSurvey(isHelpful: Bool, faqId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
            ApiService.shared.submitFAQSurvey(isHelpful: isHelpful, faqId: faqId) { result in
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

    }
