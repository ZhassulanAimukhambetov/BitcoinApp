//
//  TransactionsTableViewController.swift
//  BitcoinApp
//
//  Created by Zhassulan Aimukhambetov on 12/6/19.
//  Copyright © 2019 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    
    private let identifier = "toDetailTransaction"
    var transactions: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TransactionNetworkService.getTransactions { (transactions) in
            self.transactions = transactions
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
    }
}

// MARK: - TableView DataSource

extension TransactionsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transaction = transactions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.configure(transaction, indexPath: indexPath)
        return cell
    }
}

// MARK: - TableView Navigation

extension TransactionsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == identifier,
        let cell = sender as? TransactionCell,
        let indexPath = tableView.indexPath(for: cell) else { return }
        let transaction = transactions[indexPath.row]
        let detailVC = segue.destination as? TransactionDetailViewController
        detailVC?.transaction = transaction
    }
}
