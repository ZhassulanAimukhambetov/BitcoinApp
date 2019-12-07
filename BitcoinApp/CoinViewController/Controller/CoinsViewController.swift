//
//  CoinsViewController.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/5/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit
import Charts

class CoinsViewController: UIViewController {

    
    @IBOutlet weak var historyChartView: LineChartView!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var periodSegmentControl: UISegmentedControl!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currency = Currency(rawValue: currencySegmentControl.selectedSegmentIndex) else { return }
        guard  let period = Period(rawValue: periodSegmentControl.selectedSegmentIndex) else { return }
        
        configureChartView()
        configureSegmentControl()
        updateCurrencyValue(currency: currency)
        updateCurrencyHistory(currency: currency, period: period)
    }
    
    //MARK: - @IBActions
    
    @IBAction func currencySegmentControlSelect(_ sender: UISegmentedControl) {
        guard let currency = Currency(rawValue: sender.selectedSegmentIndex) else { return }
        updateCurrencyValue(currency: currency)
        guard let period = Period(rawValue: periodSegmentControl.selectedSegmentIndex) else { return }
        updateCurrencyHistory(currency: currency, period: period)
    }
    
    @IBAction func periotSegmentControlSelect(_ sender: UISegmentedControl) {
        guard let period = Period(rawValue: sender.selectedSegmentIndex) else { return }
        guard let currency = Currency(rawValue: currencySegmentControl.selectedSegmentIndex) else { return }
        updateCurrencyHistory(currency: currency, period: period)
    }
    
    //MARK: - getData
    
    func updateCurrencyHistory(currency: Currency, period: Period) {
        HistoryNetworkService.getDataPoints(currency: currency, period: period) { (dataPoints) in
            DispatchQueue.main.async {
                self.setChart(dataHistory: dataPoints, currency: currency, period: period)
            }
        }
    }
    
    func updateCurrencyValue(currency: Currency) {
        CoinNetworkService.getCoin(currency: currency) { (coin) in
            DispatchQueue.main.async {
                self.rateValueLabel.text = "\(coin.rateFloat.formatingToString())\(currency.symbol)"
            }
        }
    }
    
    //MARK: - Configure
    
    func configureSegmentControl() {
        periodSegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        currencySegmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    func configureChartView() {
        historyChartView.xAxis.drawLabelsEnabled = false
        historyChartView.leftAxis.enabled = false
        historyChartView.leftAxis.drawGridLinesEnabled = false
        historyChartView.rightAxis.enabled = false
        historyChartView.rightAxis.drawGridLinesEnabled = false
        historyChartView.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
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
        
        historyChartView.data = chartData
        historyChartView.animate(xAxisDuration: 0.3, yAxisDuration: 0.2)
    }
}
