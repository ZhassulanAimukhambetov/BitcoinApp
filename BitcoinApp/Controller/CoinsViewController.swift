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
    
    @IBOutlet weak var bitcoinChartView: LineChartView!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var periodSegmentControl: UISegmentedControl!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodSegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        currencySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        guard let currency = Currency(rawValue: currencySegmentControl.selectedSegmentIndex) else { return }
        guard  let period = Period(rawValue: periodSegmentControl.selectedSegmentIndex) else { return }
        
        updateCurrencyValue(currency: currency)
        updateCurrencyHistory(currency: currency, period: period)
    }
    
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
    
    func updateCurrencyHistory(currency: Currency, period: Period) {
        HistoryNetworkService.getHistory(currency: currency, period: period) { (dataY) in
            DispatchQueue.main.async {
                self.setChart(values: dataY, currency: currency, period: period)
            }
        }
    }
    
    func updateCurrencyValue(currency: Currency) {
        CoinNetworkService.getCoin(currency: currency) { (coin) in
            DispatchQueue.main.async {
                self.rateValueLabel.text = "\(coin.rateFloat.formatingToString())\(currency.text)"
            }
        }
    }
    
    func setChart (values: [Double], currency: Currency, period: Period) {
        
        var yValues = [ChartDataEntry]()
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i + 1), y: values[i])
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: currency.name)
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .white
        lineDataSet.drawFilledEnabled = true
        
        var chartDataSet: [LineChartDataSet] = [LineChartDataSet]()
        chartDataSet.append(lineDataSet)
        
        bitcoinChartView.leftAxis.enabled = false
        bitcoinChartView.leftAxis.drawGridLinesEnabled = false
        bitcoinChartView.rightAxis.enabled = false
        bitcoinChartView.rightAxis.drawGridLinesEnabled = false
        bitcoinChartView.backgroundColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)

        let chartData: LineChartData = LineChartData(dataSets: chartDataSet)
        bitcoinChartView.data = chartData
        bitcoinChartView.animate(xAxisDuration: 0.3, yAxisDuration: 0.2)
    }
}
