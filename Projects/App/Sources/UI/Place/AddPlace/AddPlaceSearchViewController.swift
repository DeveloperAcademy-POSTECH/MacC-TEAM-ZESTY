//
//  AddPlaceSearchViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class AddPlaceSearchViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = AddPlaceViewModel()
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var searchingTextFieldView = SearchTextField()
    private lazy var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    private lazy var searchButton: UIButton = {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let largeBoldDoc = UIImage(systemName: "magnifyingglass", withConfiguration: largeConfig)
        $0.setImage(largeBoldDoc, for: .normal)
        $0.backgroundColor = .black
        $0.tintColor = .white
        $0.layer.cornerRadius = 45/2
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonDidTap() {
        print("검색버튼이 눌렸어요")
    }
    
}

// MARK: - UI Function

extension AddPlaceSearchViewController {
    
    private func configureUI() {
        view.backgroundColor = .white // zestyColor(.backgroundColor)
    }
    
    private func createLayout() {
        view.addSubviews([searchingTextFieldView, searchButton, tableView])
        
        searchingTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(searchingTextFieldView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(45)
        }
        
    }
    
    private func setNavigationBar() {
        navigationItem.title = "맛집등록"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

/*
// MARK: - Previews

extension AddPlaceSearchPreview: PreviewProvider {
    
    static var previews: some View {
        AddPlaceSearchViewController().toPreview()
    }
    
}
*/
