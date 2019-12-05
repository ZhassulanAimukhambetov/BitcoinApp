//
//  Extensions.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/5/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

extension Double {
    func formatingToString() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = " "
        formater.numberStyle = .decimal
        if self < 0.01 {
            formater.maximumFractionDigits = 6
        } else if self < 1 {
            formater.maximumFractionDigits = 4
        } else {
            formater.maximumFractionDigits = 2
        }
        return formater.string(from: NSNumber(value: self))!
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
