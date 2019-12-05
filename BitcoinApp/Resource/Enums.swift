//
//  Enums.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/5/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

enum Currency: Int {
    case KZT
    case USD
    case EUR
    
    var name: String {
        switch self {
        case .USD: return "USD"
        case .EUR: return "EUR"
        case .KZT: return "KZT"
        }
    }
    
    var text: String {
        switch self {
        case .USD: return "＄"
        case .EUR: return "€"
        case .KZT: return "₸"
        }
    }
}

enum Period: Int {
    case week
    case month
    case year
    
    var interval: TimeInterval {
        switch self {
        case .week: return (-7 * 60 * 60 * 24)
        case .month: return (-30 * 60 * 60 * 24)
        case .year: return (-12 * 30 * 60 * 60 * 24)
        }
    }
    
    var count: Int {
        switch self {
        case .week: return 1
        case .month: return 7
        case .year: return 30
        }
    }
}
