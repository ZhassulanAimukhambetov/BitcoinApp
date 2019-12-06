//
//  Transaction.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

struct Transaction {
    let date: Date
    let id: Int
    let price: Double
    let type: TransactionType
    let amount: Double
    
    init? (json: [String: AnyObject]) {
        guard let date = json["date"] as? String,
        let id = json["tid"] as? Int,
        let price = json["price"] as? String,
        let type = json["type"] as? Int,
        let amount = json["amount"] as? String else { return nil }
        
        guard let date1 = Int(date) else { return nil }
        self.date = Date(timeIntervalSince1970: TimeInterval(date1))
        self.id = id
        self.price = Double(price) ?? 0
        self.type = TransactionType(rawValue: type) ?? TransactionType.buy
        self.amount = Double(amount) ?? 0
        
    }
}
