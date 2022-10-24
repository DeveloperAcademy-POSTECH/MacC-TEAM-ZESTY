//
//  ReviewCardViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SnapKit

final class ReviewCardViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let cardView = ReviewCardView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension ReviewCardViewController {
    
    private func configureUI() {
        view.addSubview(cardView)
    }
    
    private func createLayout() {
        cardView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(45)
            $0.height.equalTo(cardView.snp.width).multipliedBy(1.3)
        }
    }
    
}

// MARK: - Previews

struct ReviewCardVCPreview: PreviewProvider {
    
    static var previews: some View {
        ReviewCardViewController().toPreview()
    }
    
}
