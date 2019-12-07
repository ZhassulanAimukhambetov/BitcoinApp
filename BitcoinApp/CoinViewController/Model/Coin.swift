//
//  Coin.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Coin: Decodable {
    let code : String
    let rate : String
    let description : String
    let rateFloat : Double
    
    private enum CodingKeys : String, CodingKey {
        case code, rate, description, rateFloat = "rate_float"
    }
}
