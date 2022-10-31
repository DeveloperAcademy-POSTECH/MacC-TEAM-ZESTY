import AuthenticationServices
import Combine
import UIKit
import DesignSystem
import SnapKit

final class ThirdPartyLoginViewController: UIViewController {
    
    // MARK: - Properties
    
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
    }
    
    // MARK: - Function
    
    @objc private func termsOfServiceLabelClicked() {
        
    }
    
    @objc func kakaoLoginButtonClicked() {
        viewModel.kakaoLogin()
    }
    
    @objc func appleLoginButtonClicked() {
        navigationController?.pushViewController(NickNameInputViewController(), animated: true)
    }
    
}

// MARK: - Bind Function
extension ThirdPartyLoginViewController {
    
    private func bindUI() {
        viewModel.isUserRegisteredSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isUserRegistered in
                guard let self = self else { return }
                if isUserRegistered {
                    self.navigationController?.pushViewController(NickNameInputViewController(), animated: true)
                }
            }
            .store(in: &cancelBag)
    }
    
}

// MARK: - UI Function
extension ThirdPartyLoginViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
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
        termsOfServiceLabel.textColor = UIColor.zestyColor(.gray3C3C43)
        
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
