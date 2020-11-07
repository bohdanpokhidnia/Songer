//
//  StringDateFormatter.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.10.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import Foundation

class StringDateFormatter {
    
    private let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.locale = Locale(identifier: "en_US")
    }
    
    func dateToString(_ date: Date) -> String {
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func stringToDate(_ stringDate: String, _ format: String = "dd.MM.yyyy") -> Date {
        
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: stringDate)
        
        if let date = date {
            return date
        } else {
            return Date()
        }
    }
    
    func formatStringDate(_ stringDate: String, _ format: String = "dd.MM.yyyy", _ dateStyle: DateFormatter.Style = .none) -> String? {
        
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: stringDate)
        
        if let date = date {
            dateFormatter.dateStyle = dateStyle
            
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
