//
//  History.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/7/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

typealias History = [String : Double]

struct Result: Decodable {
    let history: History
    private enum CodingKeys : String, CodingKey {
        case history = "bpi"
    }
}
