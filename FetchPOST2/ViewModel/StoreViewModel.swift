//
//  StoreViewModel.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 12/12/24.
//


import Foundation

class StoreViewModel {
    
    private var store: stores
    var storeName: String {
        return store.storeName
    }
    
    var storeAddress: String {
        return store.storeAddress
    }

    var storeImagePath: URL? {
        return URL(string: store.storeImagePath)
    }
    var businessHours: String? {
        let currentDay = getTodayDay()
        if let todayBusinessHour = store.businessHours.first(where: { $0.day.uppercased() == currentDay }) {
            if todayBusinessHour.isAvalilable247 {
                return "Open 24/7"
            } else {
                guard let timings = todayBusinessHour.storeTimings?.first else { return nil }
                let openTime = formatToAMPM(timings.openTime)
                let closeTime = formatToAMPM(timings.closeTime)
                return "Timing: \(openTime) - \(closeTime)"
            }
        }
        
        return nil
    }
    
    
    var contactPhoneNumber: String {
        return store.contactPerson?.phoneNumber ?? "N/A"
    }

    var contactEmail: String {
        return store.contactPerson?.email ?? "N/A"
    }
    
    
    
    var amenities: [Amenity] {
           return store.amenities
       }
    

    init(store: stores) {
        self.store = store
    }
    func getTodayDay() -> String {
        return fetchCurrentDay()
    }
    private func fetchCurrentDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: Date()).uppercased()
    }
    private func formatToAMPM(_ time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
            //return formattedTime.replacingOccurences(of: " ", with: "")
        }
        return time
    }
}
