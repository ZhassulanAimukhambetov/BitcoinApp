//
//  Transaction.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Transaction: Decodable {
    let date: String
    let id: Int
    let price: String
    let type: Int
    let amount: String
    
    private enum CodingKeys : String, CodingKey {
        case date, id = "tid", price, type, amount
    }
}
