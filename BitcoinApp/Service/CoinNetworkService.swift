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
        NetworkService.shared.getData(url: url) { (json) in
            guard let json = json as? [String : AnyObject] else { return }
            guard let base = json["bpi"] as? [String : AnyObject] else { return }
            guard let coinData = base[currency.name] as? [String : AnyObject] else { return }
            guard let coin = Coin(json: coinData) else { return }
            completion(coin)
        }
    }
}

