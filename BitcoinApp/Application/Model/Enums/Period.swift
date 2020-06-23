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

    var urlDateString: (startDate: String, endDate: String)? {
        let date = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .weekday], from: date)
        switch self {
        case .week:
            //Unfortunately, during the weekend there is no record of the course, and when requesting statistics on Sunday, only five values were returned. So I had to write such ugly code.
            switch dateComponents.weekday {
            case 1:
                let endDate = Calendar.current.date(byAdding: .day, value: -2, to: date)
                return datePeriod(from: endDate, period: 6)
            case 7:
                let endDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
                return datePeriod(from: endDate, period: 6)
            default:
                return datePeriod(from: date, period: 6)
            }
        case .month:
            return datePeriod(from: date, period: 28)
        case .year:
            return datePeriod(from: date, period: 360)
        }
    }
    
    private func datePeriod(from date: Date?, period: Int) -> (String, String)? {
        guard let endDate = date else { return nil }
        guard let startDate = Calendar.current.date(byAdding: .day, value: -period, to: endDate) else { return nil }
        return (startDate.formatingToString(), endDate.formatingToString())
    }
}
