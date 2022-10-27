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
    
    private let segmentIndicator = UIView()
    private let segmentedControl = UISegmentedControl(items: ["전체", "선정맛집"])

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
        removeBackgroundAndDivider()
        segmentIndicator.backgroundColor = .black
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        
    }
    
    private func removeBackgroundAndDivider() {
        let removeBackgroundDivider = UIImage()
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(removeBackgroundDivider, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func createLayout() {
        view.addSubviews([segmentedControl, segmentIndicator])
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(173)
        }
        
        segmentIndicator.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(3)
            make.height.equalTo(3)
            make.width.equalTo(20)
            make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
    }
    
}

// MARK: - Preview

struct PlaceListViewControllerTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: PlaceListViewController()).toPreview()
    }
    
}
