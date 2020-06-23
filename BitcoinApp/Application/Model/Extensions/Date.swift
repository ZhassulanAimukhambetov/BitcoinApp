//
//  Date.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 6/23/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

extension Date {
    func formatingToString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
