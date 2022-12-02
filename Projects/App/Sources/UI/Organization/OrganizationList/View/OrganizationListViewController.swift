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
import Firebase
import SnapKit

final class OrganizationListViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel = OrganizationListViewModel()
    
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var searchingTextFieldView = SearchTextField(placeholder: "대학교 검색")
    private let searchButton = UIButton(type: .custom)
    private lazy var searchingTextField = searchingTextFieldView.textField
    private let tableView = UITableView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setNavigationBar()
        createLayout()
        bindUI()
    }
    
    // MARK: Function
    
    @objc func searchButtonTapped() {
        searchingTextField.resignFirstResponder()
        analytics()
        searchingTextField.delegate = self
    }
    
    private func analytics() {
        FirebaseAnalytics.Analytics.logEvent("organization_list_viewed", parameters: [
            AnalyticsParameterScreenName: "organization_list"
        ])
    }
    
    @objc private func backButtonDidTap() {
        if let viewController = navigationController?.viewControllers.first(where: {$0 is ThirdPartyLoginViewController}) {
              navigationController?.popToViewController(viewController, animated: true)
        }
    }
    
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
        if viewModel.searchedOrgArray.count == 0 {
            if searchingTextFieldView.textField.text == "" {
                tableView.setEmptyView(message: "참여할 대학교를\n알려주세요", type: .search)
            } else {
                tableView.setEmptyView(message: "검색 결과가 없어요.", type: .noresult)
            }
        } else {
            tableView.restore()
        }
        return viewModel.searchedOrgArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrganizationListCell.identifier, for: indexPath) as? OrganizationListCell
        guard let cell = cell else { return UITableViewCell() }
        let organization = viewModel.searchedOrgArray[indexPath.row]
        cell.bind(with: organization)
        
        return cell
    }
    
}

extension OrganizationListViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

extension OrganizationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let organization = viewModel.searchedOrgArray[indexPath.row]
        let domainSettingVC = DomainSettingViewController(organization: organization)
        
        navigationController?.pushViewController(domainSettingVC, animated: true)
    }
    
}

// MARK: UI Function

extension OrganizationListViewController {
    
    private func configureUI() {
        view.backgroundColor = .background
        
        navigationItem.title = "대학 선택"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        
        searchingTextFieldView.placeholder = "대학교 검색"
        searchingTextField.delegate = self
        searchingTextField.becomeFirstResponder()
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .default)
        let largeBoldDoc = UIImage(systemName: "magnifyingglass", withConfiguration: largeConfig)
        searchButton.setImage(largeBoldDoc, for: .normal)
        searchButton.backgroundColor = .blackComponent
        searchButton.tintColor = .reverseLabel
        searchButton.layer.cornerRadius = 45/2
        searchButton.clipsToBounds = true
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        tableView.register(OrganizationListCell.self, forCellReuseIdentifier: OrganizationListCell.identifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .background
    }
    
    private func setNavigationBar() {
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonDidTap))
        rightBarButton.tintColor = .accent
        navigationItem.leftBarButtonItem = rightBarButton
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
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}
