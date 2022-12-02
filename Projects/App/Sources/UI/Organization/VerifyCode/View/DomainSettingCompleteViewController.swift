//
//  DomainSettingCompleteViewController.swift
//  App
//
//  Created by 김태호 on 2022/11/08.
//  Copyright (c) 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class DomainSettingCompleteViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    private let viewModel = DomainSettingCompleteViewModel()
    
    private let isSE: Bool = UIScreen.main.isHeightLessThan670pt
    
    private lazy var titleView = MainTitleView(title: "\(viewModel.orgName)에\n참가했어요🎉", subtitle: "이제 나의 맛집을 공유하고 평가를 남겨보세요.")
    private let cardView = UIView()
    private let signupImageView = UIImageView()
    private let cardOrgLabel = UILabel()
    private let cardUserNameLabel = UILabel()
    private let startButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
    @objc func startButtonTapped() {
        navigationController?.pushViewController(PlaceListViewController(), animated: true)
    }
    
}

// MARK: - UI Function

extension DomainSettingCompleteViewController {
    
    private func configureUI() {
        view.backgroundColor = .background
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 16
        cardView.layer.applyFigmaShadow(color: .shadow, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        cardView.backgroundColor = .cardFill
        
        signupImageView.image = UIImage(.img_signup)
        signupImageView.contentMode = .scaleAspectFit
        
        cardOrgLabel.text = viewModel.orgName
        cardOrgLabel.font = .systemFont(ofSize: 22, weight: .bold)
        cardOrgLabel.textColor = .label
        cardOrgLabel.numberOfLines = 2
        
        cardUserNameLabel.text = viewModel.userName
        cardUserNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        cardUserNameLabel.textColor = .secondaryLabel
        
        startButton.setTitle("완료", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func createLayout() {
        view.addSubviews([titleView, cardView, startButton])
        cardView.addSubviews([signupImageView, cardOrgLabel, cardUserNameLabel])
        
        titleView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(isSE ? 250 : 300)
            make.height.equalTo(isSE ? 320 : 400)
        }
        
        signupImageView.snp.makeConstraints { make in
            make.width.height.equalTo(isSE ? 100 : 130)
            make.center.equalToSuperview()
        }
        
        cardOrgLabel.snp.makeConstraints { make in
            make.bottom.equalTo(cardUserNameLabel.snp.bottom).offset(-30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        cardUserNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}

/*
// MARK: - Previews

extension DomainSettingCompletePreview: PreviewProvider {
    
    static var previews: some View {
        DomainSettingCompleteViewController().toPreview()
    }
    
}
*/
