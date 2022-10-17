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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureDataSource()
        applySnapShot()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension PlaceListViewController: UICollectionViewDelegate {

    private func configureHierachy() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, _ in
            let sectionType = SectionType(index: sectionIndex)
            let section: NSCollectionLayoutSection
            
            let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                            elementKind: Self.headerType,
                                                                            alignment: .topLeading)
            
            switch sectionType {
            case .banner:
                section = self.createSectionLayout(width: .fractionalWidth(1), height: .fractionalHeight(0.4))
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
            case .picked:
                section = self.createSectionLayout(width: .fractionalWidth(0.35), height: .fractionalHeight(0.23))
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
            case .whole:
                section = self.createSectionLayout(width: .fractionalWidth(1), height: .fractionalHeight(0.4))
                section.boundarySupplementaryItems = [sectionHeader]

            }
            
            return section
        }
        return layout
    }
    
    private func createSectionLayout(width: NSCollectionLayoutDimension,
                                     height: NSCollectionLayoutDimension) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        
        return section
    }
    
    private func configureDataSource() {
        let etcCellRegisteration = UICollectionView.CellRegistration<UICollectionViewCell, Tmp> { cell, _, _ in
            cell.backgroundColor = .blue
        }

        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let section = SectionType(rawValue: indexPath.section) else { return nil }
            switch section {
            case .banner:
                return collectionView.dequeueConfiguredReusableCell(using: etcCellRegisteration, for: indexPath, item: item)
            case .picked:
                return collectionView.dequeueConfiguredReusableCell(using: etcCellRegisteration, for: indexPath, item: item)
            case .whole:
                return collectionView.dequeueConfiguredReusableCell(using: etcCellRegisteration, for: indexPath, item: item)
            }
        })

        typealias SupplymentaryViewRegistration = UICollectionView.SupplementaryRegistration<UICollectionReusableView>

        let headerRegisteration = SupplymentaryViewRegistration(elementKind: Self.headerType) { supplementaryView, _, _ in
//            guard let section = Section(rawValue: index.section) else { return }
            supplementaryView.backgroundColor = .orange
        }

        dataSource.supplementaryViewProvider = { collectionView, _, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegisteration, for: index)
        }
    }
    
    private func applySnapShot() {
        var snapshot = Snapshot()
        let sections = SectionType.allCases
        snapshot.appendSections(sections)
        snapshot.appendItems([Tmp(), Tmp(), Tmp()], toSection: .banner)
        snapshot.appendItems([Tmp(), Tmp(), Tmp(), Tmp()], toSection: .picked)
        snapshot.appendItems([Tmp(), Tmp(), Tmp(), Tmp(), Tmp()], toSection: .whole)
        dataSource.apply(snapshot)
    }

}

extension PlaceListViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionType, Tmp>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, Tmp>
    
    static let headerType = "section-header-element-kind"

    enum SectionType: Int, CaseIterable {
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

// MARK: - Preview

struct PlaceListViewControllerTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        PlaceListViewController().toPreview()
    }

}
