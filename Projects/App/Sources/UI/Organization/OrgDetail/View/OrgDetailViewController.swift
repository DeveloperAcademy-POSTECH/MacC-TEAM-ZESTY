//
//  OrgDetailView.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/12.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import SnapKit

final class OrgDetailViewController: UIViewController {

    // MARK: Properties
    
    private let inviteButton = UIButton()
    private let orgName = UILabel()
    private let orgLogo = UIImageView()
    private let orgUsers = UILabel()
    private let orgUsersBackground = UIImageView()
    private let orgPlace = UILabel()
    private let orgPlacePhoto = UILabel()

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }

    // MARK: Function
    
}

extension OrgDetailViewController {

    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .systemGray3
        
        orgName.text = "킹밥는대학교"
        orgName.textColor = .black
        orgName.font = UIFont.systemFont(ofSize: CGFloat(36), weight: .bold)
        
        orgLogo.image = UIImage(systemName: "seal.fill")
        orgLogo.tintColor = .black
        orgLogo.contentMode = .scaleAspectFit
        orgLogo.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36))
        
        orgUsers.text = "218명의 Zesters"
        orgUsers.textColor = .white
        orgUsers.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .regular)
        orgUsers.textAlignment = .center
        
        orgUsersBackground.image = UIImage(systemName: "seal.fill")
        orgUsersBackground.tintColor = .systemIndigo
        orgUsersBackground.contentMode = .scaleAspectFit
        orgUsersBackground.preferredSymbolConfiguration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
        
        inviteButton.configuration = .filled()
        inviteButton.tintColor = .black
        inviteButton.setTitle("우리학교 사람들 초대하기", for: .normal)
        inviteButton.configuration?.buttonSize = .large
    }

    private func createLayout() {
        view.addSubview(orgName)
        view.addSubview(orgLogo)
        view.addSubview(orgUsers)
        view.addSubview(orgUsersBackground)
        view.addSubview(inviteButton)

        orgName.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX).offset(-20)
            make.top.equalTo(view.snp.top).offset(50)
        }
        
        orgLogo.snp.makeConstraints { make in
            make.top.equalTo(orgName.snp.top).offset(-2)
            make.left.equalTo(orgName.snp.right)
        }
        
        orgUsers.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        orgUsersBackground.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX).offset(-90)
            make.centerY.equalTo(view.snp.centerY)
        }

        inviteButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(300)
        }
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self)
    }
}

struct OrgDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        OrgDetailViewController().toPreview()
    }
}
#endif
