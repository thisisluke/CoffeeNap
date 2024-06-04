//
//  LabelViewController.swift
//  CoffeeNap
//
//  Created by Luke Liu on 4/6/2024.
//

import UIKit

final class LabelViewController: BaseViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
}
