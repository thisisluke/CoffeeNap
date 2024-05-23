//
//  UIView+Extension.swift
//  CoffeeNap
//
//  Created by Luke Liu on 23/5/2024.
//

import UIKit

extension UIView {
    /// Add array of subviews to view.
    ///
    /// - Parameter subviews: array of subviews to add to self.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
