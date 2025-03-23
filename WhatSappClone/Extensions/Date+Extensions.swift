//
//  Date+Extensions.swift
//  WhatSappClone
//
//  Created by Khanh Nguyen on 18/3/25.
//

import Foundation

extension Date {
    var dayOrTimeRepresentation: String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        if calendar.isDateInToday(self){
            dateFormatter.dateFormat = "h:mm a"
            let formattedDate = dateFormatter.string(from: self)
            return formattedDate
        } else if calendar.isDateInToday(self){
            return "Yesterday"
        } else {
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
        
    }
    
    var formatToTime: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: self)
        return formattedTime
    }
}
