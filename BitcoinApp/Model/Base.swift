//
//  Base.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Base {
    
    let disclaimer: String
    let coins: [String : Coin]
    
    init? (json: [String : AnyObject]) {
        guard let disclaimer = json["disclaimer"] as? String,
              let coins = json["bpi"] as? [String : Coin] else { return nil }
        self.disclaimer = disclaimer
        self.coins = coins
    }
}
