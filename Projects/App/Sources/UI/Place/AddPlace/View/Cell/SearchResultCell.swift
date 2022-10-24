//
//  SearchResultCell.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class SearchResultCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .label
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let addressLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let nextIcon: UIImageView = {
        $0.image = UIImage(systemName: "chevron.right")
        $0.tintColor = .label
        return $0
    }(UIImageView())
    
    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        createLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Function
    func setup(with place: Place) {
        DispatchQueue.main.async {
            self.nameLabel.text = place.name
            self.addressLabel.text = place.address
        }
    }
        
}

    // MARK: - UI Function

extension SearchResultCell {
    
    private func configureUI() {
        self.backgroundColor = .zestyColor(.background)
    }
    
    private func createLayout() {
        contentView.addSubviews([nameLabel, addressLabel, nextIcon])
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(42)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(42)
        }
        
        nextIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(12)
            $0.height.equalTo(21)
        }
    }
    
}
