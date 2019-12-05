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
    
    static func getCoin (currencyName: CurrencyName, completion: @escaping (Coin) -> Void) {
        let urlString = urlApi + currencyName.rawValue + ".json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (json) in
            let json = json as! [String : AnyObject]
            guard let base = json["bpi"] as? [String : AnyObject] else { return }
            guard let currency = base[currencyName.rawValue] as? [String : AnyObject] else { return }
            guard let coin = Coin(json: currency) else { return }
            //print(coin)
            completion(coin)
        }
    }
}

enum CurrencyName: String {
    case USD
    case EUR
    case KZT
}
