//
//  ProfilePlaceHolder.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/07.
//  Copyright © 2022 zesty. All rights reserved.
//

import AuthenticationServices
import Combine
import UIKit
import DesignSystem
import Firebase
import SnapKit

final class ThirdPartyLoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var appleAuthorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        return authorizationController
    }()
    
    private let mainTitleView = MainTitleView(title: "안녕하세요,\n제스티입니다", subtitle: "로그인하여 모든 맛집을 확인하세요.")
    private let backgroundImageView = UIImageView()
    private let viewModel = ThirdPartyLoginViewModel()
    private let loginStackView = UIStackView()
    private let termsOfServiceLabel = UILabel()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    
    private var cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        configureUI()
        createLayout()
        bindUI()
        analytics()
    }
    
    // MARK: - Function
    
    @objc private func termsOfServiceLabelClicked() {
        termsOfServiceLabel.showAnimation {
            UrlUtils.openExternalLink(urlStr: "https://avery-in-ada.notion.site/bc452553120c48e986541111425ebb7d")
        }
    }
    
    @objc func kakaoLoginButtonClicked() {
        viewModel.kakaoLogin()
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSignUp, parameters: [
            AnalyticsParameterMethod: "kakao"
        ])
    }
    
    @objc func appleLoginButtonClicked() {
        appleAuthorizationController.performRequests()
        FirebaseAnalytics.Analytics.logEvent(AnalyticsEventSignUp, parameters: [
            AnalyticsParameterMethod: "apple"
        ])
    }
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("thirdparty_login_viewed", parameters: [
            AnalyticsParameterScreenName: "thirdparty_login"
        ])
    }
    
}

extension ThirdPartyLoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.appleLogin(authorization: authorization)
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
}

// MARK: - Bind Function
extension ThirdPartyLoginViewController {
    
    private func bindUI() {
        viewModel.shouldSetNicknameSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldSetNickname in
                guard let self = self else { return }
                if shouldSetNickname {
                    self.navigationController?.pushViewController(NickNameInputViewController(state: .signup), animated: true)
                } else {
                    self.navigationController?.pushViewController(PlaceListViewController(), animated: true)
                }
            }
            .store(in: &cancelBag)
        
        viewModel.shouldSetOrganizationSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.pushViewController(OrganizationListViewController(), animated: true)
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function
extension ThirdPartyLoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .background
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .accent
        
        backgroundImageView.image = UIImage(.img_login)
        backgroundImageView.contentMode = .scaleAspectFit
        
        loginStackView.axis = .vertical
        loginStackView.spacing = 20
        
        let termsOfServiceLabelText = "‘계속하기' 버튼을 누르시면\n이용약관에 동의하시게 됩니다."
        let attributedText = NSMutableAttributedString(string: termsOfServiceLabelText,
                                                       attributes: [.font: UIFont.preferredFont(forTextStyle: .footnote)])
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: (termsOfServiceLabelText as NSString).range(of: "이용약관"))
        termsOfServiceLabel.attributedText = attributedText
        termsOfServiceLabel.textAlignment = .center
        termsOfServiceLabel.numberOfLines = 2
        termsOfServiceLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsOfServiceLabelClicked)))
        termsOfServiceLabel.isUserInteractionEnabled = true
        termsOfServiceLabel.textColor = .secondaryLabel
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonClicked), for: .touchUpInside)
        kakaoLoginButton.setImage(UIImage(.btn_kakaologin), for: .normal)
        kakaoLoginButton.imageView?.contentMode = .scaleAspectFit
        
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonClicked), for: .touchUpInside)
        appleLoginButton.setImage(UIImage(.btn_applelogin), for: .normal)
        appleLoginButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func createLayout() {
        view.addSubviews([mainTitleView, backgroundImageView, termsOfServiceLabel, loginStackView])
        loginStackView.addArrangedSubviews([kakaoLoginButton, appleLoginButton])
        
        mainTitleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(130)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(mainTitleView.snp.bottom).offset(20)
            make.bottom.equalTo(termsOfServiceLabel.snp.top).offset(-20)
        }
        
        termsOfServiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginStackView.snp.top).offset(-20)
            make.height.greaterThanOrEqualTo(40)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        appleLoginButton.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
    }
    
}

#if DEBUG
import SwiftUI
struct ThirdPartyLoginViewTemplatePreview: PreviewProvider {
    
    static var previews: some View {
        ThirdPartyLoginViewController().toPreview()
    }

}
#endif
