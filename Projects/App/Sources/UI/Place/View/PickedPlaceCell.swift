//
//  PickedPlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit

final class PickedPlaceCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - UI Function

extension PickedPlaceCell {
    
    func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}

// MARK: - Preview

struct PickedPlaceCellPreview: PreviewProvider {
    
    static var previews: some View {
        PickedPlaceCell().toPreview()
    }

}
