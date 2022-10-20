//
//  ReviewRegisterViewController.swift
//  App
//
//  Created by 리아 on 2022/10/20.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import SwiftUI
import UIKit
import SnapKit

final class ReviewRegisterViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension ReviewRegisterViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}

// MARK: - Previews

struct ReviewRegisterPreview: PreviewProvider {
    
    static var previews: some View {
        ReviewRegisterViewController().toPreview()
    }
    
}
