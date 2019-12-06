//
//  TransactionNetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class TransactionNetworkService {
    
    static private let urlApi = "https://www.bitstamp.net/api/transactions/"
    
    static func getTransactions(completion: @escaping ([Transaction]) -> Void) {
        guard let url = URL(string: urlApi) else { return }
        NetworkService.shared.getData(url: url) { (json) in
            guard let json = json as? [[String : AnyObject]] else { return }
            var transactions = [Transaction]()
            for value in json {
                guard let transaction = Transaction(json: value) else { continue }
                transactions.append(transaction)
            }
            completion(transactions)
        }
    }
}
