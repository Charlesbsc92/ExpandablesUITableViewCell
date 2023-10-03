//
//  Transaction.swift
//  Task
//
//  Created by Charles on 12/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

//
//  Goal.swift
//  Task
//
//  Created by Charles on 12/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

class Transaction:Codable {
    
    // Mark - Property
    var date:String
    var description:String
    var amount:String
    
    public func getAmount() -> String {
        if amount.isEmpty {
            return "0.00"
        }else {
            return amount
        }
    }
    
}

