//
//  PlaceListViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Updated by 리아 on 2022/11/01.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import Firebase
import SnapKit

final class PlaceListViewController: UIViewController {
    
    // MARK: - Properties

    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: PlaceListViewModel
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Place>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Place>
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    private var snapshot = Snapshot()
    private let headerType = "section-header-element-kind"
    
    // MARK: - LifeCycle
    
    init(viewModel: PlaceListViewModel = PlaceListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureDataSource()
        analytics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reset()
        bind()
        viewModel.initialFetch()
    }
    
    // MARK: - Function
    
    private func bind() {
        viewModel.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] placeList in
                guard let self = self else { return }
                self.applySnapshot(with: placeList)
            }
            .store(in: &cancelBag)
    }
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("place_list_viewed", parameters: [
            AnalyticsParameterScreenName: "place_list"
        ])
    }

}

extension PlaceListViewController: UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let rows = indexPaths.map { $0.row }
        viewModel.prefetch(at: rows)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let placeId = viewModel.result[indexPath.row].id
        let placeDetailViewModel = PlaceDetailViewModel(placeId: placeId)
        show(PlaceDetailViewController(viewModel: placeDetailViewModel), sender: nil)
    }
    
}

// MARK: - UI function

protocol AddPlaceDelegate: AnyObject {
    func addPlaceButtonTapped()
}

extension PlaceListViewController: AddPlaceDelegate {
    
    func addPlaceButtonTapped() {
        navigationController?.pushViewController(AddPlaceSearchViewController(viewModel: AddPlaceSearchViewModel()), animated: true)
    }
    
    @objc func orgDetailButtonTapped() {
        navigationController?.pushViewController(OrgDetailViewController(viewModel: OrgDetailViewModel(orgId: UserInfoManager.userInfo?.userOrganization ?? 400)), animated: true)
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSelectItem, parameters: [
            AnalyticsParameterItemListName: "org_detail_button"
        ])
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(SearchPlaceViewController(viewModel: SearchPlaceViewModel()), animated: true)
    }
    
    @objc func userInfoButtonTapped() {
         navigationController?.pushViewController(ProfileViewController(), animated: true)
    }

}

// MARK: - Configure CollectionView

extension PlaceListViewController {

    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        view.addSubview(collectionView)
    }

    private func createLayout() -> UICollectionViewLayout {
        let section: NSCollectionLayoutSection
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        section = NSCollectionLayoutSection(group: group)
        
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: headerType,
                                                                        alignment: .topLeading)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        let cellRegisteration = UICollectionView.CellRegistration<PlaceCell, Place> { cell, _, item in
            cell.setUp(with: item)
        }
        typealias SupplymentaryViewRegistration = UICollectionView.SupplementaryRegistration<SegmentHeaderView>
        let headerRegisteration = SupplymentaryViewRegistration(elementKind: headerType) { [weak self] supplementaryView, _, _ in
            guard let self = self else { return }
            supplementaryView.viewModel = self.viewModel
            supplementaryView.addPlaceDelegate = self
        }
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        })
        dataSource.supplementaryViewProvider = { collectionView, _, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegisteration, for: index)
        }
    }

    private func applySnapshot(with items: [Place]) {
        snapshot.deleteAllItems()
        snapshot.appendSections([1])
        snapshot.appendItems(items, toSection: 1)
        dataSource.apply(snapshot)
    }

}

extension PlaceListViewController {
    
    private func configureUI() {
        configureNaviBar()
    }
    
    private func configureNaviBar() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        let personCropCircle = UIImage(systemName: "person.crop.circle")
        let userInfoItem = UIBarButtonItem(image: personCropCircle, style: .plain, target: self, action: #selector(userInfoButtonTapped))
        let placeTitle = UILabel()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(orgDetailButtonTapped))

        placeTitle.text = "애플디벨로퍼아카데미"
        placeTitle.font = .systemFont(ofSize: 17, weight: .bold)
        placeTitle.isUserInteractionEnabled = true
        placeTitle.addGestureRecognizer(tapGesture)
        
        navigationItem.rightBarButtonItems = [userInfoItem, searchItem]
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: placeTitle)
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct PlaceListViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceListViewController().toPreview()
    }
    
}
#endif
