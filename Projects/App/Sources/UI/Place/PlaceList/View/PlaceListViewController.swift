//
//  PlaceListViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Updated by 고반 on 2022/12/03.
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
    
    private let refreshControl = UIRefreshControl()
    
    private var emptyView = UIView()
    private var emptyImageView = UIImageView()
    private var emptyLabel = UILabel()
    
    private let placeTitle = UILabel()
    
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
        configureHierarchy()
        configureDataSource()
        createLayout()
        configureUI()
        bind()
        analytics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindResult()
    }
    
    // MARK: - Function
    
    private func bind() {
        UserInfoManager.shared.isNameFetched
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.placeTitle.text = UserInfoManager.userInfo?.userOrgName
            }
            .store(in: &cancelBag)
    }
    
    private func bindResult() {
        viewModel.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] placeList in
                guard let self = self else { return }
                self.applySnapshot(with: placeList)
                self.setEmptyView(placeList)
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
            viewModel.reset()
            viewModel.initialFetch()
        }
    }
    
}

// MARK: - UI function

protocol QuestionButtonTapDelegate: AnyObject {
    func questionButtonTapped(sourceView: UIView)
}

protocol AddPlaceDelegate: AnyObject {
    func addPlaceButtonTapped()
}

extension PlaceListViewController: QuestionButtonTapDelegate, UIAdaptivePresentationControllerDelegate,
                                   UIPopoverPresentationControllerDelegate,
                                   AddPlaceDelegate {

    func questionButtonTapped(sourceView: UIView) {
        let questionPopover = ExplanationPopOverViewController()
        
        questionPopover.modalPresentationStyle = .popover
        questionPopover.preferredContentSize.height = 70
        questionPopover.popoverPresentationController?.popoverLayoutMargins = UIEdgeInsets(top: 100, left: 200, bottom: 0, right: 20)
        questionPopover.popoverPresentationController?.permittedArrowDirections = []
        questionPopover.popoverPresentationController?.delegate = self

        questionPopover.popoverPresentationController?.sourceRect = sourceView.bounds
        questionPopover.popoverPresentationController?.sourceView = sourceView

        present(questionPopover, animated: true)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func addPlaceButtonTapped() {
        navigationController?.pushViewController(AddPlaceSearchViewController(viewModel: AddPlaceSearchViewModel()), animated: true)
    }
      
    @objc func orgDetailButtonTapped() throws {
        
        if let orgId = UserInfoManager.userInfo?.userOrganization.first {
            navigationController?.pushViewController(OrgDetailViewController(viewModel: OrgDetailViewModel(orgId: orgId)),
                                                     animated: true)
        } else {
            let alert = UIAlertController(title: "인증대학없음",
                                          message: "등록되어 있는 대학 정보가 없습니다",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "닫기", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
        
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
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
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
            supplementaryView.questionButtonDelegate = self
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
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}

extension PlaceListViewController {
    
    private func configureUI() {
        configureNaviBar()

        emptyImageView.image = UIImage(.img_emptyfriends_noresult)
        emptyImageView.contentMode = .scaleAspectFit
        emptyLabel.text = "아직 등록된 맛집이 없어요"
        emptyLabel.font = .zestyFont(size: .body, weight: .medium)
        emptyLabel.textColor = .dim
    }
    
    private func setEmptyView(_ result: [Place]) {
        emptyView.isHidden = !result.isEmpty
    }
    
    private func configureNaviBar() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        let personCropCircle = UIImage(systemName: "person.crop.circle")
        let userInfoItem = UIBarButtonItem(image: personCropCircle, style: .plain, target: self, action: #selector(userInfoButtonTapped))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(orgDetailButtonTapped))
        
        placeTitle.text = UserInfoManager.userInfo?.userOrgName ?? "(인증대학없음)"
        placeTitle.font = .systemFont(ofSize: 17, weight: .bold)
        placeTitle.isUserInteractionEnabled = true
        placeTitle.addGestureRecognizer(tapGesture)
        
        navigationItem.rightBarButtonItems = [userInfoItem, searchItem]
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: placeTitle)
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isHidden = false
    }
    
    private func createLayout() {
        view.addSubview(emptyView)
        emptyView.addSubviews([emptyLabel, emptyImageView])
        
        emptyView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyImageView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.top.centerX.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
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
