//
//  OrganizationListViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class OrganizationListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = OrganizationListViewModel()
    
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var searchingTextFieldView = SearchTextField()
    private let searchButton = UIButton(type: .custom)
    private lazy var searchingTextField = searchingTextFieldView.textField
    private let tableView = UITableView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bindUI()
        searchingTextField.delegate = self
    }
    
    // MARK: Function
    
}

// MARK: Bind UI

extension OrganizationListViewController {
    
    private func bindUI() {
        viewModel.$searchedOrgArray
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self = self else { return }
                    self.tableView.reloadData()
            }
            .store(in: &cancelBag)
        
        searchingTextField.textDidEndEditingPublisher
                            .compactMap { $0.text }
                            .receive(on: DispatchQueue.main)
                            .assign(to: \.userTextInput, on: viewModel)
                            .store(in: &cancelBag)
    }
    
}

// MARK: Delegate

extension OrganizationListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedOrgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrganizationListCell.identifier, for: indexPath) as? OrganizationListCell
        guard let cell = cell else { return UITableViewCell() }
        cell.orgNameLabel.text = viewModel.searchedOrgArray[indexPath.row]
        
        return cell
    }
    
}

extension OrganizationListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

extension OrganizationListViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
        setNavigationBar()
        
        searchingTextFieldView.placeholder = "대학교 검색"
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let largeBoldDoc = UIImage(systemName: "magnifyingglass", withConfiguration: largeConfig)
        searchButton.setImage(largeBoldDoc, for: .normal)
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
        searchButton.layer.cornerRadius = 45/2
        searchButton.clipsToBounds = true
        
        tableView.dataSource = self
        tableView.register(OrganizationListCell.self, forCellReuseIdentifier: OrganizationListCell.identifier)
        tableView.separatorStyle = .none
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchingTextFieldView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "대학 선택"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}
