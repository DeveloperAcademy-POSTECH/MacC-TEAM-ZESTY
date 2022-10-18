//
//  PlaceDetailViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/11.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit
import DesignSystem

final class PlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel = PlaceDetailViewModel()
    private let place: Place
    private let reviews: [Review] = [Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3]]

    private lazy var addReviewButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("리뷰 남기기 버튼", for: .normal)
        $0.addTarget(self, action: #selector(addReviewButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var reviewTitleLabel: UILabel = {
        $0.text = "리뷰"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        return $0
    }(UILabel())
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Initialization
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        setUpCollectionView()
        bind()
    }
    
    // MARK: - Function
    
    @objc func addReviewButtonDidTap() {
        // TODO: - 리뷰 남기기 버튼 눌렀을때 동작추가
    }
}

extension PlaceDetailViewController {
    
    // MARK: - UI Function
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.cellID)
        collectionView.register(PlaceDetailHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "PlaceDetailHeaderView")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func createLayout() {
        view.addSubviews([reviewTitleLabel, collectionView, addReviewButton])
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1000)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        addReviewButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
}

// MARK: - Bind
extension PlaceDetailViewController {
    
    private func bind() {
        
    }
    
}

// MARK: - Collection View
extension PlaceDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.cellID, for: indexPath) as? ReviewCell else { return UICollectionViewCell()}
        let review = reviews[indexPath.row]
        cell.setup(with: review)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "PlaceDetailHeaderView",
                for: indexPath
              ) as? PlaceDetailHeaderView else {return UICollectionReusableView()}
        header.setUp(with: place)
        return header
    }
}

extension PlaceDetailViewController: UICollectionViewDelegate {
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 219.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemWidth(for: view.frame.width, spacing: 0)
        
        return CGSize(width: width/1.15, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return finalWidth - 5.0
    }
}

extension PlaceDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 445.0)
        
    }
    
}
