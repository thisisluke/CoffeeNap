//
//  BaseSectionBackgroundView.swift
//  CoffeeNap
//
//  Created by Luke Liu on 23/5/2024.
//

import UIKit

class BaseSectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
