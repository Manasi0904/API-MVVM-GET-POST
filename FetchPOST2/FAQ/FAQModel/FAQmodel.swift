//
//  FAQmodel.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 17/12/24.
//

import UIKit

    struct FAQCategoryResponse: Codable {
        let faqCategory: [FAQCategory]
    }

    struct FAQCategory: Codable {
        let status: String
        let faqCategoryTitle: String
      //let imagePath: String
        let faqCategoryId: Int
    }

   
struct FAQResponse: Codable {
   let faqCategoryId: Int
    let faqCategoryTitle: String
           let faq: [FAQ]
       }
    
    struct FAQ: Codable {
            let status: String
           let answer: String
            let question: String
            let faqId: Int
}
    
    
    

