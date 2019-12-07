//
//  CoinNetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class CoinNetworkService {
    
    static private let urlApi: String = "https://api.coindesk.com/v1/bpi/currentprice/"
    
    static func getCoin (currency: Currency, completion: @escaping (Coin) -> Void) {
        let urlString = urlApi + currency.name + ".json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (data) in
            do {
                let bitcoinData = try JSONDecoder().decode(Base.self, from: data())
                guard let coin = bitcoinData.coins[currency.name] else { return }
                completion(coin)
            } catch let error {
                print(error)
            }
        }
    }
}

