//
//  NetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    func getData(url: URL, completion: @escaping (Any) -> Void) {

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options:[])
                completion(json)
            } catch {
                print(error)
            }
        }.resume()
    }
}
