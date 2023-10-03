//
//  Enum.swift
//  Task
//
//  Created by Charles on 14/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation

public enum ViewState:String {
    case viewMore = "ViewMore"
    case viewLess = "ViewLess"
    public func toString() -> String {
        return self.rawValue
    }
}
