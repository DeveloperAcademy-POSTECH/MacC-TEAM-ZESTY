//
//  SubPlaceListViewControllerViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class PlaceListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cancelBag = Set<AnyCancellable>()
    
    private let headerView = UIView()
    
    private let segmentIndicator = UIView()
    private let segmentedControl = UISegmentedControl(items: ["전체", "선정맛집"])
    
    private let questionButton = UIButton()
    private let addPlaceButton = UIButton()
    
    private let tableView = UITableView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!.count))
        if selectedIndex == 1 {
            segmentIndicator.snp.remakeConstraints { (make) in
                make.top.equalTo(segmentedControl.snp.bottom).offset(3)
                make.height.equalTo(3)
                make.width.equalTo(titlecount * 11)
                make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(2.58 + CGFloat(selectedIndex-1.0)*2.0))
            }
        } else {
            segmentIndicator.snp.makeConstraints { make in
                make.top.equalTo(segmentedControl.snp.bottom).offset(3)
                make.height.equalTo(3)
                make.width.equalTo(20)
                make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.segmentIndicator.transform = CGAffineTransform(scaleX: 1.1, y: 1)
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.segmentIndicator.transform = CGAffineTransform.identity
            })
        }
    }
    
    @objc func searchButtonTapped() {
        // TODO: 검색뷰 완성 시 연결
        // 임시로 상세페이지 연결 둡니다
        let placeId = 18
        navigationController?.pushViewController(PlaceDetailViewController(viewModel: PlaceDetailViewModel(placeId: placeId)), animated: true)
    }
    
    @objc func userInfoButtonTapped() {
        // TODO: 민이 만든 프로필 뷰로 이동
         navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc func addPlaceButtonTapped() {
        
        navigationController?.pushViewController(AddPlaceSearchViewController(viewModel: AddPlaceSearchViewModel()), animated: true)
    }
    
}

// MARK: - UI function

extension PlaceListViewController {
    
    private func configureUI() {
        removeBackgroundAndDivider()
        configureNaviBar()
        
        view.backgroundColor = .white
        
        headerView.backgroundColor = .white
        
        segmentIndicator.backgroundColor = .black
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        let questionMarkImage = UIImage(systemName: "questionmark.circle", withConfiguration: imageConfiguration)
        
        questionButton.setImage(questionMarkImage, for: .normal)
        questionButton.tintColor = .zestyColor(.gray54)
        
        let sidePlusImage = UIImage(.btn_side_plus)
        addPlaceButton.setImage(sidePlusImage, for: .normal)
        addPlaceButton.addTarget(self, action: #selector(addPlaceButtonTapped), for: .touchUpInside)

        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    private func configureNaviBar() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        let personCropCircle = UIImage(systemName: "person.crop.circle")
        let userInfoItem = UIBarButtonItem(image: personCropCircle, style: .plain, target: self, action: #selector(userInfoButtonTapped))
        let placeTitle = UILabel()
        
        placeTitle.text = "애플디벨로퍼아카데미"
        placeTitle.font = .systemFont(ofSize: 17, weight: .bold)
        
        navigationItem.rightBarButtonItems = [userInfoItem, searchItem]
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: placeTitle)
        navigationItem.hidesBackButton = true
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func removeBackgroundAndDivider() {
        let removeBackgroundDivider = UIImage()
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(removeBackgroundDivider, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func createLayout() {
        view.addSubviews([headerView, tableView])
        headerView.addSubviews([segmentedControl, segmentIndicator, questionButton, addPlaceButton])
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(85)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(172)
            make.height.equalTo(32)
        }
        
        segmentIndicator.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(20)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
        
        questionButton.snp.makeConstraints { make in
            make.left.equalTo(segmentedControl.snp.right)
            make.top.equalTo(segmentedControl.snp.top)
            make.width.equalTo(21)
            make.height.equalTo(21)
        }
        
        addPlaceButton.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(65)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}

extension PlaceListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell
        guard let cell = cell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension PlaceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
