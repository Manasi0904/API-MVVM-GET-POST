//
//  ApiService.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 10/12/24.
//
//
//import Foundation
//class ApiService {
//    static let shared = ApiService()
//    private init() {}
//    let urlString = "http://restaurant-api.reciproci.com/api/ns/store/unsec/v1/getNearByStores"
//    func fetchStoreData(completion: @escaping (Result<[stores], Error>) -> Void) {
//        guard URL(string: urlString) != nil else { return }
//        let parameters: [String: String] = [
//            "pageSize": "10",
//            "latitude": "28.592777",
//            "longitude": "77.31881081534289",
//            "page": "0"
//        ]
//
//        var urlComponents = URLComponents(string: urlString)
//        urlComponents?.queryItems = parameters.map{ URLQueryItem(name: $0.key, value: $0.value) }
//        guard let finalURL = urlComponents?.url else {return}
//        var request  = URLRequest(url: finalURL)
//            request.httpMethod = "GET"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.setValue("5LlYVeSLsLCmCc0Js7CxpvSSTa3bivSqtZa09lMl46R0LwQ7Wu59ee+g3RKnMzo3VAhaNKgzPHDITfoU3l1w==", forHTTPHeaderField: "GUEST_USER_TOKEN")
//            request.setValue("iOS", forHTTPHeaderField: "DEVICE_TYPE")
//            request.setValue("India", forHTTPHeaderField: "COUNTRY")
//            request.setValue("1733721216400", forHTTPHeaderField: "modifiedTime")
//            request.setValue("2.1.8.8", forHTTPHeaderField: "APP_VERSION")
//            request.setValue("EN", forHTTPHeaderField: "Accept-Language")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print("API call error: \(error)")
//                    completion(.failure(error))
//                    return
//                }
//
//                guard let data = data else {
//                    print("No data received from API")
//                    return
//                }
//
//                do {
//                    print(try JSONSerialization.jsonObject(with: data))
//                    let storeResponse = try JSONDecoder().decode(StoreResponse.self, from: data)
//                   print("my Fetched Data: \(storeResponse.stores)")
//                    completion(.success(storeResponse.stores))
//
//                } catch {
//
//                    print("Error decoding response: \(error)")
//                    completion(.failure(error))
//                }
//            }.resume()
//        }
//    }
//
//
//
//




import Foundation
class ApiService {
    static let shared = ApiService()
    private init() {}
    
    let storeUrlString = "http://restaurant-api.reciproci.com/api/ns/store/unsec/v1/getNearByStores"
    let faqCategoryUrlString = "https://restaurant-api.reciproci.com/api/ns/faq/category/v1/unsec/get"
    let faqUrlString = "https://restaurant-api.reciproci.com/api/ns/faq/v1/unsec/get"
    
    func fetchStoreData(completion: @escaping (Result<[stores], Error>) -> Void) {
        guard URL(string: storeUrlString) != nil else { return }
        let parameters: [String: String] = [
            "pageSize": "10",
            "latitude": "28.592777",
            "longitude": "77.31881081534289",
            "page": "0"
        ]
        
        var urlComponents = URLComponents(string: storeUrlString)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let finalURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("5LlYVeSLsLCmCc0Js7CxpvSSTa3bivSqtZa09lMl46R0LwQ7Wu59ee+g3RKnMzo3VAhaNKgzPHDITfoU3l1w==", forHTTPHeaderField: "GUEST_USER_TOKEN")
        request.setValue("iOS", forHTTPHeaderField: "DEVICE_TYPE")
        request.setValue("India", forHTTPHeaderField: "COUNTRY")
        request.setValue("1733721216400", forHTTPHeaderField: "modifiedTime")
        request.setValue("2.1.8.8", forHTTPHeaderField: "APP_VERSION")
        request.setValue("EN", forHTTPHeaderField: "Accept-Language")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API call error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received from API")
                return
            }
            
            do {
                let storeResponse = try JSONDecoder().decode(StoreResponse.self, from: data)
                completion(.success(storeResponse.stores))
            } catch {
                print("Error decoding response: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchFAQCategories(completion: @escaping (Result<[FAQCategory], Error>) -> Void) {
        guard let url = URL(string: faqCategoryUrlString) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("EN", forHTTPHeaderField: "Accept-Language")
        request.setValue("2.1.8.3", forHTTPHeaderField: "APP_VERSION")
        request.setValue("India", forHTTPHeaderField: "COUNTRY")
        request.setValue("Belagavi", forHTTPHeaderField: "CITY")
        request.setValue("1734075046692", forHTTPHeaderField: "modifiedTime")
        request.setValue("iOS", forHTTPHeaderField: "DEVICE_TYPE")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("FAQ Categories API error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received from FAQ Categories API")
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let faqCategoryResponse = try JSONDecoder().decode(FAQCategoryResponse.self, from: data)
                completion(.success(faqCategoryResponse.faqCategory))
            } catch {
                print("Error decoding FAQ Categories: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func fetchFAQQuestions(for categoryId: Int, completion: @escaping (Result<[FAQ], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: faqUrlString) else {
            return
        }
        
        // Add the parameters as query items to the URL
        let parameters: [String: String] = [
            "faqCategoryId": "\(categoryId)",
            "page": "0",
            "pageSize": "10"
        ]
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let finalURL = urlComponents.url else { return }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("EN", forHTTPHeaderField: "Accept-Language")
        request.setValue("2.1.8.3", forHTTPHeaderField: "APP_VERSION")
        request.setValue("India", forHTTPHeaderField: "COUNTRY")
        request.setValue("Belagavi", forHTTPHeaderField: "CITY")
        request.setValue("1734075047792", forHTTPHeaderField: "modifiedTime")
        request.setValue("iOS", forHTTPHeaderField: "DEVICE_TYPE")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("FAQ Questions API error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received from FAQ Questions API")
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let faqResponse = try JSONDecoder().decode(FAQResponse.self, from: data)
                completion(.success(faqResponse.faq))
            } catch {
                print("Error decoding FAQ Questions: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
    
    func submitFAQSurvey(isHelpful: Bool, faqId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://restaurant-api.reciproci.com/api/ns/faq/v1/faqSurvey") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("iOS", forHTTPHeaderField: "DEVICE_TYPE")
        request.setValue("India", forHTTPHeaderField: "COUNTRY")
        request.setValue("1734514045846", forHTTPHeaderField: "modifiedTime")
        request.setValue("2.1.8.10", forHTTPHeaderField: "APP_VERSION")
        request.setValue("EN", forHTTPHeaderField: "Accept-Language")
        request.setValue("83043029-9DBB-41CC-AB85-44896D191B8B", forHTTPHeaderField: "DEVICE_ID")
        request.setValue("Belagavi", forHTTPHeaderField: "CITY")
        request.setValue("5LlYVeSLsLCmCc0Js7CxpvSSTa3bivSqtZa09lMl46R0LwQ7Wu59ee+g3RKnMzo3VAhaNKgzPHDITfoU3l1w==", forHTTPHeaderField: "GUEST_USER_TOKEN")
       
        let body: [String: Any] = [
            "isHelpful": isHelpful,
            "faqId": faqId
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("FAQ Survey POST API error: \(error)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "APIError", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: nil)
                completion(.failure(error))
                return
            }

            completion(.success(()))
        }.resume()
    }

    
    
    
}
