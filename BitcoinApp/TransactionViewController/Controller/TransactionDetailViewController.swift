//
//  TransactionDetailViewController.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit

class TransactionDetailViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }
    
    func configureLabels() {
        guard let transaction = transaction else { return }
        idLabel.text = String(transaction.id)
        priceLabel.text = transaction.price
        countLabel.text = transaction.amount
        typeLabel.text = transaction.type == 0 ? "buy" : "sell"
        guard let dateInt = Int(transaction.date) else {
            dateLabel.text = "no date"
            return
        }
        let date = Date(timeIntervalSince1970: TimeInterval(dateInt))
        dateLabel.text = date.formatingToString(format: "MMM d, yyyy")
        timeLabel.text = date.formatingToString(format: "HH:mm:ss")
    }
}
