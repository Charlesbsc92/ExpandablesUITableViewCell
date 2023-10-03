//
//  UIView.swift
//  Task
//
//  Created by Charles on 14/05/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func removeAllViews(){
        self.subviews.forEach { $0.removeFromSuperview() }
    }
}
