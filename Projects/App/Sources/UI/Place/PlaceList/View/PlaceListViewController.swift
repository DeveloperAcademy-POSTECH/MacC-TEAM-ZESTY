//
//  PlaceListViewController.swift
//  App
//
//  Created by 리아 on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import DesignSystem

final class PlaceListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
    
    private var searchBarItem = UIBarButtonItem()
    private var profileBarItem = UIBarButtonItem()
    private let registerButton = ShadowButtonView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierachy()
        createLayout()
        configureDataSource()
        applySnapShot()
    }
    
}

// MARK: - CollectionView Function

extension PlaceListViewController: UICollectionViewDelegate {

    private func configureHierachy() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
            let sectionType = SectionType(index: sectionIndex)
            let section: NSCollectionLayoutSection
            let supplymentaryView: NSCollectionLayoutBoundarySupplementaryItem
            
            switch sectionType {
            case .banner:
                section = self.createSectionLayout(width: .fractionalWidth(1), height: .estimated(100))
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
            case .picked:
                section = self.createSectionLayout(width: .fractionalWidth(0.35), height: .estimated(100))
                supplymentaryView = createSupplymentaryViewLayout(type: .header)
                section.boundarySupplementaryItems = [supplymentaryView]
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
            case .whole:
                section = self.createSectionLayout(width: .fractionalWidth(1), height: .estimated(100))
                supplymentaryView = createSupplymentaryViewLayout(type: .header)
                section.boundarySupplementaryItems = [supplymentaryView]
            }
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
            return section
        }
        return layout
    }
    
    private func createSectionLayout(width: NSCollectionLayoutDimension,
                                     height: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        return section
    }
    
    private func createSupplymentaryViewLayout(type: SupplementaryKind) -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: SupplementaryKind.header.string,
                                                                        alignment: .topLeading)
        switch type {
        case .header:
            return sectionHeader
        default:
            return sectionHeader
        }
        
    }
    
    private func configureDataSource() {
        let bannerRegisteration = UICollectionView.CellRegistration<BannerCell, Tmp> { _, _, _ in
        }
        let pickedRegisteration = UICollectionView.CellRegistration<PickedPlaceCell, Tmp> { _, _, _ in
        }
        let wholeRegisteration = UICollectionView.CellRegistration<WholePlaceCell, Tmp> { _, _, _ in
        }

        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = SectionType(rawValue: indexPath.section) else { return nil }
            switch section {
            case .banner:
                return collectionView.dequeueConfiguredReusableCell(using: bannerRegisteration, for: indexPath, item: item)
            case .picked:
                return collectionView.dequeueConfiguredReusableCell(using: pickedRegisteration, for: indexPath, item: item)
            case .whole:
                return collectionView.dequeueConfiguredReusableCell(using: wholeRegisteration, for: indexPath, item: item)
            }
        })

        typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<PlaceListHeaderView>

        let headerRegisteration = HeaderRegistration(elementKind: SupplementaryKind.header.string) { supplementaryView, _, index in
            let title = SectionType(index: index.section).title
            supplementaryView.configureUI(with: title)
        }

        dataSource.supplementaryViewProvider = { collectionView, _, index in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegisteration, for: index)
        }
    }
    
    private func applySnapShot() {
        var snapshot = Snapshot()
        let sections = SectionType.allCases
        snapshot.appendSections(sections)
        snapshot.appendItems([Tmp()], toSection: .banner)
        snapshot.appendItems([Tmp(), Tmp(), Tmp(), Tmp()], toSection: .picked)
        snapshot.appendItems([Tmp(), Tmp(), Tmp(), Tmp(), Tmp()], toSection: .whole)
        dataSource.apply(snapshot)
    }

}

extension PlaceListViewController {
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionType, Tmp>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, Tmp>
    
    private enum SupplementaryKind {
        case header
        case footer
        
        var string: String {
            switch self {
            case .header:
                return "section-header-element-kind"
            case .footer:
                return "section-footer-element-kind"
            }
        }
    }
    
    private enum SectionType: Int, CaseIterable {
        case banner
        case picked
        case whole
        
        init(index: Int) {
            switch index {
            case 0: self = .banner
            case 1: self = .picked
            case 2: self = .whole
            default: // sectionIndex가 범위 밖인 경우
                self = .picked
            }
        }
        
        var title: String {
            switch self {
            case .picked:
                return "선정된 맛집"
            case .whole:
                return "등록된 전체 맛집"
            default:
                return ""
            }
        }
    }
    
    struct Tmp: Hashable {
        let id = UUID()
        let some: Int
        
        init(some: Int = 1) {
            self.some = some
        }
    }

}

// MARK: - UI function

extension PlaceListViewController {
    
    @objc func searchButtonPressed() {
    }

    @objc func profileButtonPressed() {
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        searchBarItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain,
                                          target: self, action: #selector(searchButtonPressed))
        profileBarItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .plain, target: self, action: #selector(profileButtonPressed))
        searchBarItem.tintColor = .black
        profileBarItem.tintColor = .black
        navigationItem.rightBarButtonItems = [searchBarItem, profileBarItem]
        navigationItem.title = "애플디벨로퍼아카데미"
        
        registerButton.button.setTitle("나의 맛집 등록하기", for: .normal)
    }
    
    private func createLayout() {
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }

}

// MARK: - Preview

struct PlaceListViewControllerTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: PlaceListViewController()).toPreview()
    }

}
