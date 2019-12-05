//
//  History.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/5/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct History {
    let dataPoints: [String : Double]
    
    init? (json: [String : AnyObject]) {
        guard let history = json["bpi"] as? [String : Double] else { return nil }
        self.dataPoints = history
    }
}
