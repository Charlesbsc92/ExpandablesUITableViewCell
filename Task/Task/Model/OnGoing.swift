//
//  Goal.swift
//  Task
//
//  Created by Charles on 12/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

class OnGoing:Codable {
    
    // Mark - Property
    var id:String
    var user_id:String
    var wish_title:String
    var wish_period:String
    var wish_period_flag:String
    var status:String
    var created_on:String
    var updated_on:String
    var is_deleted:String
    var wish_amount:String
    var wish_status:String
    var wish_percentage:String
    var daysflag:String
    var transactions:[Transaction]
    var total_amount:Int
}
