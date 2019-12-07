//
//  Base.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/7/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Base: Decodable {
    let disclaimer: String
    let coins: [String : Coin]
    
    private enum CodingKeys : String, CodingKey {
        case disclaimer, coins = "bpi"
    }
}
