//
//  Collection.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 6/23/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

extension Collection where Element: Numeric {
    /// Returns the total sum of all elements in the array
    var total: Element { return reduce(0, +) }
}

extension Collection where Element: BinaryInteger {
    /// Returns the average of all elements in the array
    var average: Double {
        return isEmpty ? 0 : Double(total) / Double(count)
    }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}
