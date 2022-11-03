//
//  SegmentHeaderView.swift
//  App
//
//  Created by 리아 on 2022/11/01.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit
import SnapKit

final class SegmentHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    var viewModel = PlaceListViewModel()
    weak var addPlaceDelegate: AddPlaceDelegate!
    
    private let segmentIndicator = UIView()
    private let segmentedControl = UISegmentedControl(items: ["전체", "선정맛집"])
    
    private let questionButton = UIButton()
    private let addPlaceButton = UIButton()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - UI Functions

extension SegmentHeaderView {
    
    @objc func addPlaceButtonTapped() {
        addPlaceDelegate.addPlaceButtonTapped()
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let numberOfSegments = CGFloat(segmentedControl.numberOfSegments)
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControl.titleForSegment(at: sender.selectedSegmentIndex)!.count))
        
        if selectedIndex == 1 {
            viewModel.placeType = .hot
            segmentIndicator.snp.remakeConstraints { (make) in
                make.top.equalTo(segmentedControl.snp.bottom).offset(3)
                make.height.equalTo(3)
                make.width.equalTo(titlecount * 11)
                make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(numberOfSegments / CGFloat(2.58 + CGFloat(selectedIndex-1.0)*2.0))
            }
        } else {
            viewModel.placeType = .whole
            segmentIndicator.snp.makeConstraints { make in
                make.top.equalTo(segmentedControl.snp.bottom).offset(3)
                make.height.equalTo(3)
                make.width.equalTo(20)
                make.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
            }
        }

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.segmentIndicator.transform = CGAffineTransform(scaleX: 1.1, y: 1)
        } completion: { _ in
            UIView.animate(withDuration: 0.4, animations: {
                self.segmentIndicator.transform = CGAffineTransform.identity
            })
        }
    }

}

extension SegmentHeaderView {
    
    private func configureUI() {
        backgroundColor = .white
        
        removeBackgroundAndDivider()
        segmentIndicator.backgroundColor = .black
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold),
                                                 NSAttributedString.Key.foregroundColor: UIColor.lightGray],
                                                for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26, weight: .bold),
                                                 NSAttributedString.Key.foregroundColor: UIColor.black],
                                                for: .selected)
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        let questionMarkImage = UIImage(systemName: "questionmark.circle", withConfiguration: imageConfiguration)
        questionButton.setImage(questionMarkImage, for: .normal)
        questionButton.tintColor = .zestyColor(.gray54)
        
        let sidePlusImage = UIImage(.btn_side_plus)
        addPlaceButton.setImage(sidePlusImage, for: .normal)
        addPlaceButton.addTarget(self, action: #selector(addPlaceButtonTapped), for: .touchUpInside)
    }
    
    private func removeBackgroundAndDivider() {
        let removeBackgroundDivider = UIImage()
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(removeBackgroundDivider, for: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(removeBackgroundDivider, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }

    private func createLayout() {
        addSubviews([segmentedControl, segmentIndicator, questionButton, addPlaceButton])
        
        segmentedControl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(172)
            $0.height.equalTo(32)
        }
        
        segmentIndicator.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(3)
            $0.height.equalTo(3)
            $0.width.equalTo(20)
            $0.centerX.equalTo(segmentedControl.snp.centerX).dividedBy(segmentedControl.numberOfSegments)
        }
        
        questionButton.snp.makeConstraints {
            $0.left.equalTo(segmentedControl.snp.right)
            $0.top.equalTo(segmentedControl.snp.top)
            $0.width.equalTo(21)
            $0.height.equalTo(21)
        }
        
        addPlaceButton.snp.makeConstraints {
            $0.centerY.right.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(65)
        }
    }

}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct SegmentHeaderPreview: PreviewProvider {
    
    static var previews: some View {
        SegmentHeaderView().toPreview()
    }
    
}
#endif
