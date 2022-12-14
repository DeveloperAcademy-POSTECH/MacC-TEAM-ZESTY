//
//  ViewController.swift
//  App
//
//  Created by Lee Myeonghwan on 2022/10/09.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit
import DesignSystem

final class ViewController: UIViewController {
    
    // MARK: Properties
    
    private let testTextField = UITextField()
    private let testButton = UIButton()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: Function
    
    @objc func changeTestTextField() {
        testTextField.text = "고반최고!"
    }
    
}

extension ViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
        testTextField.text = "킹밥네 파이팅!"
        
        testButton.configuration = .filled()
        testButton.setTitle("ZESTY", for: .normal)
        testButton.addTarget(self, action: #selector(changeTestTextField), for: .touchUpInside)
    }
    
    private func createLayout() {
        view.addSubviews([testTextField, testButton])
        
        testTextField.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
        
        testButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(30)
        }
    }
    
}

struct ViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        ViewController().toPreview()
    }

}
