//
//  OrganizationListViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import Combine
import DesignSystem
import UIKit
import SnapKit

final class OrganizationListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = OrganizationListViewModel()
    
    private var cancelBag = Set<AnyCancellable>()
    
    private let titleLabel = UILabel()
    private let searchingTextFieldView = ShadowTextFieldView()
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
        .sink {[weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()}
        .store(in: &cancelBag)
        
        searchingTextField
            .textDidEndEditingPublisher
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
        
        titleLabel.text = "참여할 대학교를 알려주세요"
        // TODO: system font size로 바꾸기
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        tableView.dataSource = self
        tableView.register(OrganizationListCell.self, forCellReuseIdentifier: OrganizationListCell.identifier)
        tableView.separatorStyle = .none
    }
    
    private func createLayout() {
        view.addSubviews([titleLabel, searchingTextFieldView, tableView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        searchingTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchingTextFieldView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
