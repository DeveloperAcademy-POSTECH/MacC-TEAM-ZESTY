//
//  PlaceListHeaderView.swift
//  App
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit

final class PlaceListHeaderView: UICollectionReusableView {

    private lazy var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension PlaceListHeaderView {

    func configureUI(with text: String) {
        backgroundColor = .clear
        label.text = text
    }

    private func createLayout() {
        addSubview(label)

        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }

}

struct SupplymentaryPreview: PreviewProvider {

    static var previews: some View {
        PlaceListHeaderView().toPreview()
    }

}
