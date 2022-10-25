//
//  OrgDatailCell.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit

final class OrgDetailCell: UIView {

    // MARK: - Properties
    private let logo = UIImageView()
    private let users = UILabel()

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Function
    
}

// MARK: - UI Function
extension OrgDetailCell {

    private func configureUI() {
        backgroundColor = .systemIndigo
        
        logo.image = UIImage(.img_reviewfriends_together)
        logo.contentMode = .scaleAspectFit
        
        users.text = "13,996명의 Zesters"
        users.textColor = .black
        users.font = UIFont.systemFont(ofSize: CGFloat(20), weight: .medium)
        users.textAlignment = .left
        users.numberOfLines = 1
    }

    private func createLayout() {
        addSubviews([logo, users])
        
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        logo.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        users.snp.makeConstraints { make in
            make.leading.equalTo(logo.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }

}

#if DEBUG
import SwiftUI

struct OrgDetailCellPreview: PreviewProvider {

    static var previews: some View {
        OrgDetailCell().toPreview()
    }

}
#endif
