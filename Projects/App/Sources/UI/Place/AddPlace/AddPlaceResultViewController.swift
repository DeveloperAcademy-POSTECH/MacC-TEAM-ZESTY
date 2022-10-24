//
//  AddPlaceResultViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class AddPlaceResultViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = AddPlaceViewModel()
    private var cancelBag = Set<AnyCancellable>()
     
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        setNavigationBar()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Binding
extension AddPlaceResultViewController {
    
    private func bind() {
    }

}

// MARK: - UI Function

extension AddPlaceResultViewController {
    
    private func configureUI() {
        view.backgroundColor = .yellow
    }
    
    private func createLayout() {
        
    }
    
    private func setNavigationBar() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

/*
// MARK: - Previews

struct AddPlaceResultPreview: PreviewProvider {
    
    static var previews: some View {
        AddPlaceResultViewController().toPreview()
    }
    
}
*/
