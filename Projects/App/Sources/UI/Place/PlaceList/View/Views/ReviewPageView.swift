//
//  ReviewPageView.swift
//  App
//
//  Created by 리아 on 2022/10/27.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import UIKit

final class ReviewPageView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - UI Functions

extension ReviewPageView {
    
   func configure(with review: Review) {
        
    }
    
    private func createLayout() {
        
    }
    
}

// MARK: - Preview

#if DEBUG
import SwiftUI

struct ReviewPagePreview: PreviewProvider {
    
    static var previews: some View {
        ReviewPageView().toPreview()
    }
    
}
#endif
