//
//  Currency.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/8/19.
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
    
    var symbol: String {
        switch self {
        case .USD: return "＄"
        case .EUR: return "€"
        case .KZT: return "₸"
        }
    }
}
