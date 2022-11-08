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
import Firebase
import SnapKit

final class ReviewRegisterViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: ReviewRegisterViewModel!
    
    private var cancelBag = Set<AnyCancellable>()
    private let keyboardShowPublisher = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    private let keyboardHidePublisher = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
    
    private let imagePickerController = UIImagePickerController()
    private let keyboardSafeArea = UIView()
    private let titleView = MainTitleView()
    private let containerView = UIView()
    private let backgroundView = UIView()
    private let plusImageView = UIImageView()
    private let menuImageView = UIImageView()
    private let imageButton = UIButton()
    private let menuTextField = UITextField()
    private let underline = UIView()
    private let registerButton = FullWidthBlackButton()
    
    // MARK: - LifeCycle
    
    init(viewModel: ReviewRegisterViewModel) {
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
        bindKeyboardAction()
        bind()
        analytics()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.imageString = ""
    }
    
    @objc private func openGallery() {
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary
        present(self.imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func registerButtonTouched() {
        viewModel.menu = menuTextField.text
        viewModel.registerReview()

        navigationController?.pushViewController(ReviewCardViewController(viewModel: viewModel), animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - Function

extension ReviewRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            menuImageView.image = image
            viewModel.uploadImage(with: image)
            viewModel.isRegisterPossible = false
            registerButton.setTitle("리뷰 등록", for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func bind() {
        viewModel.isRegisterFail
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                print(errorMessage)
                let alert = UIAlertController(title: "이미지 업로드 실패",
                                              message: errorMessage,
                                              preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self?.present(alert, animated: false)
            }
            .store(in: &cancelBag)
        
        viewModel.$isRegisterPossible
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isUploaded in
                guard let self = self else { return }
                self.registerButton.isEnabled = isUploaded
            }
            .store(in: &cancelBag)
    }
    
}

private func analytics() {
    FirebaseAnalytics.Analytics.logEvent("review_register_viewed", parameters: [
        AnalyticsParameterScreenName: "review_register"
    ])
}

// MARK: - UI Function

extension ReviewRegisterViewController {
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        titleView.titleLabel.text = "\(viewModel.placeName)에서\n무엇을 드셨나요?"
        
        var config = UIImage.SymbolConfiguration(paletteColors: [.darkGray])
        config = config.applying(UIImage.SymbolConfiguration(weight: .semibold) )
        let plusImage = UIImage(systemName: "plus", withConfiguration: config)
        plusImageView.image = plusImage
        backgroundView.backgroundColor = .zestyColor(.grayF6)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        menuImageView.contentMode = .scaleAspectFill
        menuImageView.clipsToBounds = true
        menuImageView.layer.cornerRadius = 10
        
        imageButton.clipsToBounds = true
        imageButton.layer.cornerRadius = 10
        imageButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        
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
        containerView.addSubviews([backgroundView, plusImageView, menuImageView,
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
        menuImageView.snp.makeConstraints {
            $0.edges.equalTo(backgroundView.snp.edges)
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
        UINavigationController(rootViewController: ReviewRegisterViewController(viewModel: ReviewRegisterViewModel(placeId: 0, placeName: "요기쿠시동"))).toPreview()
    }
    
}
#endif
