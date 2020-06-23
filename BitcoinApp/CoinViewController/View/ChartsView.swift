//
//  ChartsView.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 6/23/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import Charts

class ChartsView: LineChartView {
    
    func configureChartView() {
        self.xAxis.drawLabelsEnabled = false
        self.leftAxis.enabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.rightAxis.enabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
    }
    
    func setChart (dataHistory: [Double], currency: Currency, period: Period) {
        var yValues = [ChartDataEntry]()
        for (index, value) in dataHistory.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: currency.name)
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .white
        lineDataSet.drawFilledEnabled = true
        lineDataSet.circleRadius = 3.0
        lineDataSet.circleHoleRadius = 2.0
        
        var chartDataSet: [LineChartDataSet] = []
        chartDataSet.append(lineDataSet)
        let chartData = LineChartData(dataSets: chartDataSet)
        
        self.data = chartData
        self.animate(xAxisDuration: 0.3, yAxisDuration: 0.2)
    }
}
