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
    
    var transaction: Transaction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }
    
    func configureLabels() {
        guard let transaction = transaction else { return }
        idLabel.text = String(transaction.id)
        dateLabel.text = transaction.date.formatingToCellString()
        priceLabel.text = transaction.price.formatingToString()
        typeLabel.text = transaction.type.name
        countLabel.text = transaction.amount.formatingToString()
    }
}
