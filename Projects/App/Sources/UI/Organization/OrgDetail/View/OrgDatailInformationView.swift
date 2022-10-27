//
//  OrgDatailCell.swift
//  App
//
//  Created by Keum MinSeok on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
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
        informationLabel.textAlignment = .center
        informationLabel.numberOfLines = 1
                
        numberLabel.textColor = .black
        numberLabel.font = UIFont.systemFont(ofSize: CGFloat(17), weight: .medium)
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 1
    }

    private func createLayout() {
        addSubviews([informationLabel, numberLabel])
        
        informationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(informationLabel.snp.bottom).offset(4)
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
