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
    
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: PlaceListViewModel

    private let headerView = UIView()
    private let segmentIndicator = UIView()
    private let segmentedControl = UISegmentedControl(items: ["전체", "선정맛집"])
    
    private let questionButton = UIButton()
    private let addPlaceButton = UIButton()
    
    private let tableView = UITableView()
    
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
        createLayout()
        bind()
    }
    
    // MARK: - Function
    
    private func bind() {
        viewModel.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancelBag)
    }

}

extension PlaceListViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell
        guard let cell = cell else { return UITableViewCell() }
        let place = viewModel.result[indexPath.row]
        cell.setUp(with: place)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let rows = indexPaths.map { $0.row }
        viewModel.prefetch(at: rows)
    }
    
}

extension PlaceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeId = viewModel.result[indexPath.row].id
        let placeDetailViewModel = PlaceDetailViewModel(placeId: placeId)
        show(PlaceDetailViewController(viewModel: placeDetailViewModel), sender: nil)
    }
    
}

// MARK: - UI function

extension PlaceListViewController {
    
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
    }
    
    @objc func userInfoButtonTapped() {
        // TODO: 민이 만든 프로필 뷰로 이동
         navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    @objc func addPlaceButtonTapped() {
        
        navigationController?.pushViewController(AddPlaceSearchViewController(viewModel: AddPlaceSearchViewModel()), animated: true)
    }

}

extension PlaceListViewController {
    
    private func configureUI() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        
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
    }
    
    private func configureNaviBar() {
        let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(userInfoButtonTapped))
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

// MARK: - Previews

#if DEBUG
import SwiftUI

struct PlaceListViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceListViewController().toPreview()
    }
    
}
#endif
