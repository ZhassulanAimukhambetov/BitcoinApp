//
//  ConvertViewController.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit

class ConvertViewController: UIViewController {
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyCountLabel: UILabel!
    @IBOutlet weak var bitcoinCountLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    private var currencyPrice: Double!
    private var isCurrencyConvert = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currency = Currency(rawValue: currencySegmentControl.selectedSegmentIndex) else { return }
        
        configureSegmentControl()
        updateCurrencyValue(currency: currency) {

        }
    }
    
    //MARK: - @IBActions
    
    @IBAction func currencySegmentControlSelect(_ sender: UISegmentedControl) {
        if isCurrencyConvert {
            currencyLabel.text = Currency(rawValue: sender.selectedSegmentIndex)?.text
        } else {
            bitcoinLabel.text = Currency(rawValue: sender.selectedSegmentIndex)?.text
        }
        guard let currency = Currency(rawValue: sender.selectedSegmentIndex) else { return }
        updateCurrencyValue(currency: currency) {
            DispatchQueue.main.async {
                self.calculate()
            }
        }
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        writeNumber(tag: sender.tag)
        calculate()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let currencyCountString = currencyCountLabel.text ?? ""
        if currencyCountString.count == 1 {
            currencyCountLabel.text = "0"
            bitcoinCountLabel.text = "0"
        } else {
            currencyCountLabel.text = String(currencyCountString.dropLast())
        }
        calculate()
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
        let currencyCountString = currencyCountLabel.text ?? "0"
        for char in currencyCountString {
            if char == "." {
                return
            }
        }
        currencyCountLabel.text = currencyCountString == "0" ? "0." : currencyCountString + "."
    }
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        isCurrencyConvert.toggle()
        let currencyCountString = currencyCountLabel.text ?? "0"
        let bitcoinCountString = bitcoinCountLabel.text ?? "0"
        let currencyString = currencyLabel.text
        let bitcoinString = bitcoinLabel.text
        currencyCountLabel.text = bitcoinCountString
        bitcoinCountLabel.text = currencyCountString
        currencyLabel.text = bitcoinString
        bitcoinLabel.text = currencyString
    }
    
    //MARK: - calculate
    
    private func calculate() {
        let currencyCountString = currencyCountLabel.text ?? "0"
        let currencyCount = Double(currencyCountString) ?? 0.0
        let bitcoinCount = isCurrencyConvert ? currencyCount/currencyPrice : currencyCount*currencyPrice
        bitcoinCountLabel.text = bitcoinCount.formatingToString()
    }
    
    private func writeNumber(tag: Int) {
        let currencyCountString = currencyCountLabel.text ?? "0"
        currencyCountLabel.text = currencyCountString == "0" ? String(tag) : currencyCountString + String(tag)
    }
    
    //MARK: - Get Price
    func updateCurrencyValue(currency: Currency, completion: @escaping () -> Void) {
        CoinNetworkService.getCoin(currency: currency) { (coin) in
            self.currencyPrice = coin.rateFloat
            completion()
        }
    }
    
    //MARK: - Configure
    
    func configureSegmentControl() {
        currencySegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        configueLabel(label: currencyCountLabel)
        configueLabel(label: bitcoinCountLabel)
        configueLabel(label: currencyLabel)
        configueLabel(label: bitcoinLabel)
    }
    
    func configueLabel(label: UILabel) {
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
    }
}
