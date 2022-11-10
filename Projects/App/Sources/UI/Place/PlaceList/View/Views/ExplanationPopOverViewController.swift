//
//  ExplanationPopOverViewController.swift
//  App
//
//  Created by 리아 on 2022/11/10.
//  Copyright (c) 2022 com.zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class ExplanationPopOverViewController: UIViewController {
    
    // MARK: - Properties
    private var explanationLabel = UILabel()
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension ExplanationPopOverViewController {
    
    private func configureUI() {
        view.backgroundColor = .zestyColor(.gray42)
        
        explanationLabel.text = "리뷰를 점수로 환산하여 특정 점수 이상이 되면 맛집으로 선정돼요"
        explanationLabel.font = .zestyFont(size: .caption1, weight: .regular)
        explanationLabel.textColor = .white
        explanationLabel.numberOfLines = 0
    }
    
    private func createLayout() {
        view.addSubview(explanationLabel)
        
        explanationLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
}

/*
// MARK: - Previews

extension ExplanationPopOverPreview: PreviewProvider {
    
    static var previews: some View {
        ExplanationPopOverViewController().toPreview().ignoresSafeArea()
 //            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
 //            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
 //            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
    }
    
}
*/
