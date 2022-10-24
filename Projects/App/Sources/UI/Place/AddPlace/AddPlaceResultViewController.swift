//
//  AddPlaceResultViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit
import Kingfisher

final class AddPlaceResultViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = AddPlaceViewModel()
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var titleView = MainTitleView(title: "맛집 등록 완료 🎉")
    
    private lazy var ticketImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(.img_ticket_bg)
        $0.layer.applyFigmaShadow(color: .black, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        return $0
    }(UIImageView())
    
    private lazy var iconView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.layer.applyFigmaShadow(color: .black, opacity: 0.25, xCoord: 0, yCoord: 0, blur: 5, spread: 0)
        return $0
    }(UIImageView())
    
    private lazy var categoryTagLabel: BasePaddingLabel = {
        $0.text = "일식"
        $0.font = .systemFont(ofSize: 11, weight: .bold)
        $0.textColor = .white
        $0.backgroundColor = .zestyColor(.point)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        return $0
    }(BasePaddingLabel())
    
    private lazy var placeNameLabel: UILabel = {
        $0.text = "요기쿠시동"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 22, weight: .bold)
        return $0
    }(UILabel())
    
    private lazy var addressLabel: UILabel = {
        $0.text = "경북 포항시 남구 효자동 11길 24-1 1층 요기쿠시동"
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var orgTitle: UILabel = {
        $0.text = "Orgnization"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var creatorTitle: UILabel = {
        $0.text = "Registered by"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var dateTitle: UILabel = {
        $0.text = "Date"
        $0.textColor = .tertiaryLabel
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var orgLabel: UILabel = {
        $0.text = "애플디벨로퍼아카데미"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var creatorLabel: UILabel = {
        $0.text = "아보카도"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var dateLabel: UILabel = {
        $0.text = "2022.10.18"
        $0.textColor = .zestyColor(.gray3C)
        $0.font = .systemFont(ofSize: 11, weight: .regular)
        return $0
    }(UILabel())
    
    private lazy var saveButton: UIButton = {
        let config = UIImage.SymbolConfiguration(paletteColors: [.zestyColor(.point) ?? .red])
        let downloadImage = UIImage(systemName: "square.and.arrow.down", withConfiguration: config)
        $0.setImage(downloadImage, for: .normal)
        $0.setTitle(" 리뷰 카드 저장하기", for: .normal)
        $0.setTitleColor(.zestyColor(.point), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        $0.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var doneButton: UIButton = {
        $0.configuration = .borderedTinted()
        $0.setTitle("완료", for: .normal)
        $0.addTarget(self, action: #selector(doneButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        setNavigationBar()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonDidTap() {
        // ShareSheet
    }
    
    @objc func doneButtonDidTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK: - Binding
extension AddPlaceResultViewController {
    
    private func bind() {
        
    }
    
}

// MARK: - UI Function

extension AddPlaceResultViewController {
    
    private func configureUI() {
        view.backgroundColor = .white // zestyColor(.backgroundColor)
        
        iconView.kf.setImage(with: URL(string:  "https://user-images.githubusercontent.com/63157395/197410857-e13c1bbb-b19a-4c59-a493-77501a4a529b.png"))
    }
    
    private func createLayout() {
        view.addSubviews([titleView, ticketImageView, saveButton, doneButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        view.sendSubviewToBack(ticketImageView)
        
        ticketImageView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).multipliedBy(1.035)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.77)
            $0.height.equalToSuperview().multipliedBy(0.59)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(ticketImageView.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
             
    }
    
    private func setNavigationBar() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

/*
 // MARK: - Previews
 
 struct AddPlaceResultPreview: PreviewProvider {
 
 static var previews: some View {
 AddPlaceResultViewController().toPreview()
 }
 
 }
 */
