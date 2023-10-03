//
//  TransactionView.swift
//  Task
//
//  Created by Charles on 13/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import UIKit
import Reusable

class TransactionView: UIView,NibLoadable {
    
    // Mark - Outlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    public func populatedData(transaction:Transaction) {
        self.amountLabel.text = "$ \(transaction.getAmount())"
        self.dateLabel.text = transaction.date
        self.descriptionLabel.text = transaction.description
    }
    
    
    
}
