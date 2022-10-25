//
//  ReviewRegisterViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class ReviewRegisterViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let keyboardShowPublisher = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    private let keyboardHidePublisher = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
    
    private let keyboardSafeArea = UIView()
    private let titleView = MainTitleView(title: "요기쿠시동에서 \n무엇을 드셨나요?")
    private let containerView = UIView()
    private let backgroundView = UIView()
    private let plusImageView = UIImageView()
    private let imageButton = UIButton()
    private let menuTextField = UITextField()
    private let underline = UIView()
    private let registerButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        createLayout()
        bindKeyboardAction()
    }

    // MARK: - Function
    
    @objc func registerButtonTouched() {
        navigationController?.pushViewController(ReviewCardViewController(), animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - UI Function

extension ReviewRegisterViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.darkGray])
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold) )
        let plusImage = UIImage(systemName: "plus", withConfiguration: config)
        plusImageView.image = plusImage
        backgroundView.backgroundColor = .zestyColor(.grayF6)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        imageButton.clipsToBounds = true
        imageButton.layer.cornerRadius = 10
        
        menuTextField.placeholder = "음식 이름"
        menuTextField.textAlignment = .center
        menuTextField.layer.masksToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        underline.clipsToBounds = true
        underline.layer.cornerRadius = 1
        underline.backgroundColor = .black
        
        registerButton.setTitle("사진 없이 리뷰 등록", for: .normal)
        registerButton.addTarget(self, action: #selector(registerButtonTouched), for: .touchUpInside)
    }
    
    private func createLayout() {
        view.addSubviews([keyboardSafeArea, titleView,
                          containerView, registerButton])
        containerView.addSubviews([backgroundView, plusImageView,
                                       imageButton, menuTextField, underline])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.width.equalTo(containerView.snp.height).multipliedBy(0.75)
        }
        backgroundView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(backgroundView.snp.width)
        }
        plusImageView.snp.makeConstraints {
            $0.center.equalTo(backgroundView.snp.center)
            $0.width.height.equalTo(35)
        }
        imageButton.snp.makeConstraints {
            $0.edges.equalTo(backgroundView.snp.edges)
        }
        menuTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(backgroundView.snp.bottom).offset(30)
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualTo(view.snp.width).inset(40)
        }
        underline.snp.makeConstraints {
            $0.leading.equalTo(menuTextField.snp.leading).offset(-10)
            $0.trailing.equalTo(menuTextField.snp.trailing).offset(10)
            $0.bottom.equalTo(menuTextField.snp.bottom).offset(5)
            $0.height.equalTo(3)
        }
        
        registerButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    
    private func bindKeyboardAction() {
        keyboardShowPublisher
            .sink { [weak self] notification in
                guard let self = self else { return }
                guard let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let endFrameHeight = endFrame.cgRectValue.height
                
                self.updateLayout(isKeyboardShown: true, with: endFrameHeight)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
        keyboardHidePublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.updateLayout(isKeyboardShown: false)
                self.view.layoutIfNeeded()
            }
            .store(in: &cancelBag)
    }
    
    private func updateLayout(isKeyboardShown: Bool, with keyboardHeight: CGFloat? = nil) {
        if isKeyboardShown {
            guard let keyboardHeight = keyboardHeight else { return }
            
            keyboardSafeArea.snp.remakeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.horizontalEdges.equalToSuperview()
                $0.bottom.equalTo(registerButton.snp.top).inset(20)
            }
            titleView.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(-20)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            titleView.willHide(with: 1)
            containerView.snp.remakeConstraints {
                $0.center.equalTo(keyboardSafeArea.snp.center)
                $0.height.equalToSuperview().multipliedBy(0.3)
                $0.width.equalTo(containerView.snp.height).multipliedBy(0.75)
            }
            registerButton.snp.remakeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview().inset(keyboardHeight + 20)
                $0.height.equalTo(55)
            }
        } else {
            titleView.snp.remakeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                $0.leading.equalToSuperview()
                $0.trailing.equalToSuperview()
            }
            titleView.willShow(with: 1)
            containerView.snp.remakeConstraints {
                $0.center.equalToSuperview()
                $0.height.equalToSuperview().multipliedBy(0.3)
                $0.width.equalTo(containerView.snp.height).multipliedBy(0.75)
            }
            registerButton.snp.remakeConstraints {
                $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
                $0.height.equalTo(55)
            }
        }
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ReviewRegisterPreview: PreviewProvider {
    
    static var previews: some View {
        UINavigationController(rootViewController: ReviewRegisterViewController()).toPreview()
    }
    
}
#endif
