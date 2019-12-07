//
//  Errors.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/7/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

public enum Errors: Error {
    case noInternetConnection
    case errorForData
    case dataEmpty
    case errorParsingData
    case urlEmpty
    
    public func message() -> String {
        switch self {
        case .noInternetConnection:
            return "No internet connection!\nMake sure your device is connected"
        case .errorForData:
            return  "Oops! We ran into an issue querying for data"
        case .dataEmpty:
            return "There seems to be no data at the moment"
        case .errorParsingData:
            return "Oops! there was an error while grabbing data"
        case .urlEmpty:
            return "We ran into an issue querying for data"
        }
    }
    static let allErrors = [noInternetConnection, errorForData, dataEmpty, errorParsingData, urlEmpty]
}
