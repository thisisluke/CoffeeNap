//
//  HomeViewController.swift
//  CoffeeNap
//
//  Created by Luke Liu on 18/5/2024.
//

import Combine
import UIKit

class HomeViewController: BaseViewController {
    enum Section: Hashable {
        case main(HomeSection)
    }
    
    enum CellType: Hashable {
        case basic(HomeItem)
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, CellType>!
    
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
        
        title = "Home"
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: .createBasicLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
    
    private func setupDataSource() {
        collectionView.register(cellWithClass: HomeCollectionViewCell.self)
        
        dataSource = UICollectionViewDiffableDataSource<Section, CellType>(collectionView: collectionView) { collectionView, indexPath, cellType -> UICollectionViewCell? in
            switch cellType {
            case .basic(let item):
                let cell = collectionView.dequeueReusableCell(withClass: HomeCollectionViewCell.self, for: indexPath)
                cell.configure(with: item)
                cell.seperator.isHidden = collectionView.numberOfItems(inSection: indexPath.section) == indexPath.row + 1
                return cell
            }
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
    
    private func applySnapshot(sections: [HomeSection]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellType>()
        snapshot.appendSections(sections.map { Section.main($0) })
        
        for section in sections {
            snapshot.appendItems(section.items.map { CellType.basic($0) }, toSection: Section.main(section))
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
