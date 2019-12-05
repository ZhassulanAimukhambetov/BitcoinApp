//
//  Coin.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Coin {

    let code : String
    let rate : String
    let description : String
    let rateFloat : Double
    
    init?(json: [String : AnyObject]) {
        guard let code = json["code"] as? String,
        let rate = json["rate"] as? String,
        let description = json["description"] as? String,
        let rateFloat = json["rate_float"] as? Double else {
            return nil
        }
        
        self.code = code
        self.rate = rate
        self.description = description
        self.rateFloat = rateFloat
    }
}
