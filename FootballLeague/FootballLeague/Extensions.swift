//
//  Extensions.swift
//  FootballLeague
//
//  Created by Yousef Elsayed on 14/09/2023.
//

import Foundation

extension String {
    func convertStringToDate() -> Date {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        return dateFormatter.date(from: self) ?? Date()
    }
    
    func convertDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMM yyyy"
        
        let outputDateStr = outputFormatter.string(from: date)
        return outputDateStr
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { 
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
