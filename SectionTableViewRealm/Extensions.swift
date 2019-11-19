//
//  Extensions.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/13/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    //custom Date init
    init?(month: Int, day: Int, year: Int) {
        guard let initDate = DateComponents(calendar: .current, year: year, month: month, day: day).date else { return nil }
        self = initDate
    }
    
    //custom Date init with hour and min
    init?(month: Int, day: Int, year: Int, hour: Int, minute: Int) {
        guard let initDate = DateComponents(calendar: .current, year: year, month: month, day: day, hour: hour, minute: minute).date else { return nil }
        self = initDate
    }
}

extension Date {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMM d, yyyy"   //ie. Tuesday Nov 12, 2019
        
        return dateFormatter.string(from: self)
    }
    
    func formatDateMonthDDYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.calendar = .current  //this will automatically detect if the user's device is using 24 hour or AM/PM
        
        return dateFormatter.string(from: self)
    }
    
    //used for dateAtStartOf and dateAtEndOf
    enum DatePeriod {
        case day
        case month
        case year
    }
    
    func dateAtStartOf(_ datePeriod: DatePeriod) -> Date {
        switch datePeriod {
        case .day:
            return Calendar.current.startOfDay(for: self)
        case .month:
            let components = Calendar.current.dateComponents([.year, .month], from: self)
            return Calendar.current.date(from: components)!
        case .year:
            let components = Calendar.current.dateComponents([.year], from: self)
            return Calendar.current.date(from: components)!
        }
    }
    
    func dateAtEndOf(_ datePeriod: DatePeriod) -> Date {
        switch datePeriod {
        case .day:
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: self))!
        case .month:
            //Start of Month Components
            let startOfMonthComponents = Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))
            let startOfMonth = Calendar.current.date(from: startOfMonthComponents)!
            
            var components = DateComponents()
            components.month = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfMonth)!
        case .year:
            //Start of Year Compents
            let startOfYearComponents = Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: self))
            let startOfYear = Calendar.current.date(from: startOfYearComponents)!
            
            var components = DateComponents()
            components.year = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfYear)!
        }
    }
}

extension UIView {
    func roundCorners(by value: CGFloat) {
        self.layer.cornerRadius = value
    }
    
    func giveRoundCorners() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}

extension Double {
    func formatCurrencyAsString() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.numberStyle = .currency
        
        let result = formatter.string(from: self as NSNumber)
        return "\(result!)"
    }
}


extension String {
    func cleanCurrencyFormatting() -> Double {
        var cleanedCurrencyAsString = ""
        
        for character in self {
            if character.isNumber {
                cleanedCurrencyAsString.append(character)
            }
        }
        
        let amountAsDouble = Double(cleanedCurrencyAsString) ?? 0.0
        
        return amountAsDouble / 100.0
    }
    
    func toDouble() -> Double {
        guard let unwrappedDouble = Double(self.replacingOccurrences(of: ",", with: "")) else { return 0.0 }
        return unwrappedDouble
    }
    
    //Source: https://stackoverflow.com/questions/29782982/how-to-input-currency-format-on-a-text-field-from-right-to-left-using-swift
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        let cleanedTextAsDouble = self.cleanCurrencyFormatting()
        let formatedAmount = cleanedTextAsDouble as NSNumber
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: formatedAmount)!
    }
}
