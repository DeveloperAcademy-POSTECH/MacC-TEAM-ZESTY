//
//  ReviewCardView.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class ReviewCardView: UIView {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
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

extension ReviewCardView {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}

// MARK: - Previews

#if DEBUG
import SwiftUI

struct ReviewCardPreview: PreviewProvider {
    
    static var previews: some View {
        ReviewCardView().toPreview()
    }
    
}
#endif
