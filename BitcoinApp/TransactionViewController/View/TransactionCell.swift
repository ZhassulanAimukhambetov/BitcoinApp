//
//  TransactionCell.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private let cellOddColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
    private let cellEvenColor = UIColor(red: 5/255, green: 5/255, blue: 5/255, alpha: 1)
    private let cellSelectedColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
    
    func configure(_ transaction: Transaction, indexPath: IndexPath) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = cellSelectedColor
        self.backgroundColor = indexPath.row % 2 == 0 ? cellOddColor : cellEvenColor
        self.selectedBackgroundView = backgroundView
        numberLabel.text = String(indexPath.row + 1)
        amountLabel.text = transaction.amount + " B"
        typeLabel.text = transaction.type == 0 ? "buy" : "sell"
        guard let dateInt = Int(transaction.date) else {
            dateLabel.text = "no date"
            return
        }
        dateLabel.text = Date(timeIntervalSince1970: TimeInterval(dateInt)).formatingToString(format: "MMM d, HH:mm:ss")
    }
}
