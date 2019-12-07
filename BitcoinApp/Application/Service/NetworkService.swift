//
//  NetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/4/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

open class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    open func getData(url: URL, completion: @escaping (_ data: () throws -> Data) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completion({ throw Errors.errorForData }) }
            guard data != nil, let data = data else { return completion({ throw Errors.dataEmpty }) }
            completion({ data })
        }.resume()
    }
}
