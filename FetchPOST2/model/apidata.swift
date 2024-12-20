//
//  apidata.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 10/12/24.
//

import Foundation
struct StoreResponse: Codable {
    let timeStamp: Int
    let stores: [stores]
}

struct stores: Codable {
    let storeName: String
    let storeAddress: String
    let storeImagePath: String
    let businessHours: [BusinessHour]
    let amenities: [Amenity]
    let contactPerson: ContactPerson?
}

    struct ContactPerson: Codable {
        let phoneNumber: String?
        let email: String?
    
}

struct BusinessHour: Codable {
    let day: String
    let isHoliday: Bool
    let isAvalilable247: Bool 
   let storeTimings: [StoreTiming]?

}


struct StoreTiming: Codable {
    let openTime: String
    let closeTime: String
}

struct Amenity: Codable {
    let amenityOid: Int
    let amenityTitle: String
    let imagePath: String
    let direction: String?
}



