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

    @IBOutlet weak var histryChartsView: ChartsView!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var periodSegmentControl: UISegmentedControl!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currency = Currency(rawValue: currencySegmentControl.selectedSegmentIndex) else { return }
        guard  let period = Period(rawValue: periodSegmentControl.selectedSegmentIndex) else { return }
        
        histryChartsView.configureChartView()
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
                self.histryChartsView.setChart(dataHistory: dataPoints, currency: currency, period: period)
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
}
