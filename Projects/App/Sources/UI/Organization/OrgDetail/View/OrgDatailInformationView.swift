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

final class OrgDetailInformationView: UIView {

    // MARK: - Properties
    
    let informationLabel = UILabel()
    let numberLabel = UILabel()

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

extension OrgDetailInformationView {

    private func configureUI() {
        backgroundColor = .zestyColor(.background)
        
        informationLabel.textColor = .zestyColor(.gray3C3C43)
        informationLabel.font = UIFont.systemFont(ofSize: CGFloat(13), weight: .regular)
        informationLabel.textAlignment = .left
        informationLabel.numberOfLines = 1
                
        numberLabel.textColor = .black
        numberLabel.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .medium)
        numberLabel.textAlignment = .left
        numberLabel.numberOfLines = 1
    }

    private func createLayout() {
        addSubviews([informationLabel, numberLabel])
        
        informationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(informationLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(8)
        }
    }

}

#if DEBUG
import SwiftUI

struct OrgDetailCellPreview: PreviewProvider {

    static var previews: some View {
        OrgDetailInformationView().toPreview()
    }

}
#endif
