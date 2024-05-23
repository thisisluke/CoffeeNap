//
//  HomeCollectionViewCell.swift
//  CoffeeNap
//
//  Created by Luke Liu on 21/5/2024.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: HomeItem) {
        iconImageView.image = UIImage(systemName: item.icon)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        iconBackgroundView.backgroundColor = UIColor(hex: item.color)
    }
    
    private func setupViews() {
        contentView.addSubviews(
            [
                iconBackgroundView,
                iconImageView,
                titleLabel,
                subtitleLabel,
                seperator
            ]
        )
        
        iconBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.center.equalTo(iconBackgroundView)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        seperator.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    // MARK: - Subviews
    
    private let iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
}
