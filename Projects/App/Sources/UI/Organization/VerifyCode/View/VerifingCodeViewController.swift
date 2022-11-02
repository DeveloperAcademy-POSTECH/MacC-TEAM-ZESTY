//
//  VerifingCodeViewController.swift
//  App
//
//  Created by 김태호 on 2022/11/02.
//  Copyright (c) 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class VerifingCodeViewController: UIViewController {
    
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

extension VerifingCodeViewController {
    
    private func configureUI() {
        
    }
    
    private func createLayout() {
        
    }
    
}

/*
// MARK: - Previews

extension VerifingCodePreview: PreviewProvider {
    
    static var previews: some View {
        VerifingCodeViewController().toPreview()
    }
    
}
*/
