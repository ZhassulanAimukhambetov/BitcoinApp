//
//  HistoryNetworkService.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/5/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation

class HistoryNetworkService {
    
    static private let urlApi: String = "https://api.coindesk.com/v1/bpi/historical/close.json"
    
    static func getHistory(currency: Currency, period: Period, completion: @escaping ([Double]) -> Void) {
        
        let endDate = Date()
        let startDate = endDate.addingTimeInterval(period.interval)

        let endDateString = getStringFromDate(date: endDate)
        let startDateString = getStringFromDate(date: startDate)

        let urlString = "\(urlApi)?currency=\(currency.name)&start=\(startDateString)&end=\(endDateString)"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (json) in
            guard let json = json as? [String : AnyObject] else { return }
            guard let history = History(json: json) else { return }
            let dataPoints = history.dataPoints.sorted {$0 < $1}
            let dataY = getDataPoints(dataPoints: dataPoints, period: period)
            completion(dataY)
        }
    }
    
    static private func getStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    static private func getDataPoints(dataPoints: [(key: String, value: Double)], period: Period) -> [Double] {
        var dataY: [Double] = []
        var sumValue: Double = 0
        var i: Int = 1
        for (_, value) in dataPoints {
            sumValue += value
            if i >= period.count {
                let averageValue = (sumValue/Double(i)).rounded(toPlaces: 2)
                dataY.append(averageValue)
                i = 0
                sumValue = 0
            }
            i += 1
        }
        return dataY
    }

}
