//
//  HomeViewController.swift
//  CoffeeNap
//
//  Created by Luke Liu on 18/5/2024.
//

import Combine
import UIKit

class HomeViewController: BaseViewController {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, HomeItem>!
    
    private let viewModel: HomeViewModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 5
            return section
        }
        return layout
    }
    
    private func setupDataSource() {
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        dataSource = UICollectionViewDiffableDataSource<Int, HomeItem>(collectionView: collectionView) { collectionView, indexPath, item -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
            cell?.configure(with: item)
            return cell
        }
    }
    
    private func bindViewModel() {
        viewModel.$sections
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sections in
                self?.applySnapshot(sections: sections)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(sections: [Int: [HomeItem]]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeItem>()
        for section in sections.keys.sorted() {
            snapshot.appendSections([section])
            if let items = sections[section] {
                snapshot.appendItems(items, toSection: section)
            }
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
