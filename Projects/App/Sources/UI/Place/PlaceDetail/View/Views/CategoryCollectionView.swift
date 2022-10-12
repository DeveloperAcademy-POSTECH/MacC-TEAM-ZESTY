//
//  CategoryCollectionView.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit

class CategoryCollectionView: UIView {
    
    // MARK: Properties
    
    public var tagList: [String] = [""]
    
    private lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellID)
        $0.delegate = self
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: .init()))
    
    // MARK: LifeCycle
    
    init() {
        super.init(frame: .zero)
        
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Function
    
    func setupData(tagList: [String]) {
        self.tagList = tagList
    }
    
}

extension CategoryCollectionView {
    
    // MARK: UI Function
    
    private func configureUI() {
        
    }
    
    private func configureLayout() {
        self.addSubviews([collectionView])
        
        collectionView.snp.makeConstraints {
            $0.center.width.equalToSuperview()
            $0.height.equalTo(100)
        }
        
    }
}

extension CategoryCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.cellID, for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
        cell.nameLabel.text = tagList[indexPath.item]
        return cell
    }
}

extension CategoryCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        lazy var label: UILabel = {
            $0.font = .systemFont(ofSize: 14)
            $0.text = tagList[indexPath.item]
            $0.sizeToFit()
            return $0
        }(UILabel())
        
        let size = label.frame.size
        
        return CGSize(width: size.width + 16, height: size.height + 10)
    }
}
