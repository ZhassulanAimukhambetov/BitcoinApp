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
    
    static func getDataPoints(currency: Currency, period: Period, completion: @escaping ([Double]) -> Void) {
        let urlString = "\(urlApi)?currency=\(currency.name)&start=\(period.urlDateString.startDate)&end=\(period.urlDateString.endDate)"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { (data) in
            do {
                let result = try JSONDecoder().decode(Result.self, from: data())
                let dataHistory = result.history.sorted {$0 < $1}
                let dataPoints = getAverageCountPoints(dataHistory: dataHistory, period: period)
                completion(dataPoints)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    static func getAverageCountPoints(dataHistory: [(key: String, value: Double)], period: Period) -> [Double] {
        var dataPoints: [Double] = []
        for (_, value) in dataHistory {
            dataPoints.append(value.rounded(toPlaces: 2))
        }
        var dataY: [Double] = []
        
        switch period {
            
        case .week:
            return dataPoints
            
        case .month:
            let pointsArray = dataPoints.chunked(into: 7)
            for point in pointsArray {
                dataY.append(point.average.rounded(toPlaces: 2))
            }
            return dataY
            
        case .year:
            let pointsArray = dataPoints.chunked(into: 30)
            for point in pointsArray {
                dataY.append(point.average.rounded(toPlaces: 2))
            }
            return dataY
        }
    }
}
