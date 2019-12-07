//
//  TransactionNetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class TransactionNetworkService {
    
    static private let urlApi = "https://www.bitstamp.net/api/transactions/?time=day"
    
    static func getTransactions(completion: @escaping ([Transaction]) -> Void) {
        guard let url = URL(string: urlApi) else { return }
        
        NetworkService.shared.getData(url: url) { (data) in
            do {
                let transactions = try JSONDecoder().decode([Transaction].self, from: data())
                completion(transactions)
            } catch let error {
                print(error)
            }
        }
    }
}
