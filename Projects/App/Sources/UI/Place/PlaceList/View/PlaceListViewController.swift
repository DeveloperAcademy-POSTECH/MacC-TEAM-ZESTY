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

// TODO: cell을 실험하기 위한 뷰입니다. 수정 예정입니다.
final class PlaceListViewController: UIViewController {
    
    // MARK: - Properties

    private let segmentIndicator = UIView()
    private let segmentedControl = UISegmentedControl(items: ["전체", "선정맛집"])
    private let questionMarkImage = UIImageView()
    private let cancelBag = Set<AnyCancellable>()
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
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
            self.segmentIndicator.transform = CGAffineTransform(scaleX: 1.1, y: 1)
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.segmentIndicator.transform = CGAffineTransform.identity
            })
        }
    }
}

// MARK: - UI function

extension PlaceListViewController {
    
    private func configureUI() {
        view.backgroundColor = .zestyColor(.background)
        
        segmentIndicator.backgroundColor = .black
        
        removeBackgroundAndDivider()
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        questionMarkImage.image = UIImage(systemName: "questionmark.circle", withConfiguration: imageConfiguration)
        questionMarkImage.tintColor = .zestyColor(.gray54)

        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    private func removeBackgroundAndDivider() {
        let removeBackgroundDivider = UIImage()
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(removeBackgroundDivider, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func createLayout() {
        view.addSubviews([segmentedControl, segmentIndicator, questionMarkImage, tableView])
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(172)
        }
        
        segmentIndicator.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(20)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
        
        questionMarkImage.snp.makeConstraints { make in
            make.left.equalTo(segmentedControl.snp.right)
            make.top.equalTo(segmentedControl.snp.top)
            make.width.equalTo(21)
            make.height.equalTo(21)
            tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            }
        
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
