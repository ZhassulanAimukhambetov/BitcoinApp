//
//  Period.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/8/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

enum Period: Int {
    case week
    case month
    case year
    
    var urlDateString: (startDate: String, endDate: String) {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .weekday], from: date)
        switch self {
        case .week:
            //Unfortunately, during the weekend there is no record of the course, and when requesting statistics on Sunday, only five values were returned. So I had to write such ugly code.
            if dateComponents.weekday == 1 {
                dateComponents.day = dateComponents.day! - 2
                let endDate = calendar.date(from: dateComponents)!
                let endDateString = endDate.formatingToString()
                dateComponents.day = dateComponents.day! - 6
                let startDate = calendar.date(from: dateComponents)!
                let startDateString = startDate.formatingToString()
                return (startDateString, endDateString)
            } else if dateComponents.weekday == 7 {
                dateComponents.day = dateComponents.day! - 1
                let endDate = calendar.date(from: dateComponents)!
                let endDateString = endDate.formatingToString()
                dateComponents.day = dateComponents.day! - 6
                let startDate = calendar.date(from: dateComponents)!
                let startDateString = startDate.formatingToString()
                return (startDateString, endDateString)
            } else {
                let endDateString = date.formatingToString()
                dateComponents.day = dateComponents.day! - 6
                let startDate = calendar.date(from: dateComponents)!
                let startDateString = startDate.formatingToString()
                return (startDateString, endDateString)
            }
        case .month:
            dateComponents.day = dateComponents.day! - 28
            let startDate = calendar.date(from: dateComponents)!
            let startDateString = startDate.formatingToString()
            let endDateString = date.formatingToString()
            return (startDateString, endDateString)
        case .year:
            dateComponents.day = dateComponents.day! - 360
            let startDate = calendar.date(from: dateComponents)!
            let startDateString = startDate.formatingToString()
            let endDateString = date.formatingToString()
            return (startDateString, endDateString)
        }
    }
}
