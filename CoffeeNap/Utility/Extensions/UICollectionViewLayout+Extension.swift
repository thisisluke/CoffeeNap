//
//  UICollectionViewLayout+Extension.swift
//  CoffeeNap
//
//  Created by Luke Liu on 23/5/2024.
//

import UIKit

extension UICollectionViewLayout {
    static func createBasicLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
            
            // Register decoration view
            let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: "sectionBackground")
            backgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
            section.decorationItems = [backgroundDecoration]
            
            return section
        }
        
        layout.register(BaseSectionBackgroundView.self, forDecorationViewOfKind: "sectionBackground")
        
        return layout
    }
}
