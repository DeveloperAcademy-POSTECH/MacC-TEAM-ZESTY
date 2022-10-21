//
//  CategoryCollectionView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem

class CategoryCollectionView: UIView {
    
    // MARK: Properties
    
    public var tagList: [Category] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCenterLayout()
        $0.collectionViewLayout = layout
        $0.isScrollEnabled = false
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellID)
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: .init()))
    
    // MARK: LifeCycle
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function
    
    func setupData(tagList: [Category]) {
        self.tagList = tagList
    }
    
}

extension CategoryCollectionView {
    
    // MARK: UI Function
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        self.addSubviews([collectionView])
        
        collectionView.snp.makeConstraints {
            $0.center.width.equalToSuperview()
            $0.height.equalTo(30)
        }
        
    }
}

extension CategoryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.cellID, for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
        cell.nameLabel.text = tagList[indexPath.item].name
        return cell
    }
}

extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        lazy var label: UILabel = {
            $0.font = .systemFont(ofSize: 13)
            $0.text = tagList[indexPath.item].name
            $0.sizeToFit()
            return $0
        }(UILabel())
        
        let size = label.frame.size
        
        return CGSize(width: size.width + 20, height: size.height + 12)
    }
}
