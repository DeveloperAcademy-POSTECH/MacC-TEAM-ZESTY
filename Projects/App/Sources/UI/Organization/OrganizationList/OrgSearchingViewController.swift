//
//  OrgSearchingViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import Combine
import SnapKit

final class OrganizationListViewController: UIViewController {
    
    // MARK: Properties
    var viewModel = OrganizationListViewModel()
    
    private var subscriptionSet = Set<AnyCancellable>()

    private var orgNameArray: [String] = []
    
    private let textFieldStackView = UIStackView()
    private let titleLabel = UILabel()
    private let searchingTextField = UITextField()
    private let tableView = UITableView()
    
    // MARK: LifeCycle
    
    override func viewDidLayoutSubviews() {
        searchingTextField.addLeftImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bindUI()
        
        searchingTextField.delegate = self
        searchingTextField
            .userInputTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.userTextInput, on: viewModel)
            .store(in: &subscriptionSet)
    }
    
    // MARK: Function

    // TODO: Govan의 UI 작업이 머지되면 다음 페이지로 넘어가는 작업을 연계할 생각입니다
    @objc func orgCellTapped() {
        // navaigationCotroller?.pushViewController(nextVc, animated: true)
    }
}

extension OrganizationListViewController {
    
    // MARK: UI Function
    
    private func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "참여할 대학교를 알려주세요"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        
        searchingTextField.placeholder = "대학교 검색"
        searchingTextField.returnKeyType = .next
        
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(OrgListCell.self, forCellReuseIdentifier: OrgListCell.identifier)
    }
    
    private func createLayout() {
        view.addSubviews([titleLabel, searchingTextField, tableView])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        searchingTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchingTextField.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func bindUI() {
        self.viewModel.$orgSearchingArray.sink { orgNameArray in
            self.orgNameArray = orgNameArray
            self.tableView.reloadData()
        }.store(in: &subscriptionSet)
    }
}

extension OrganizationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orgListcell = tableView.dequeueReusableCell(withIdentifier: OrgListCell.identifier, for: indexPath) as? OrgListCell
        
        guard let cell = orgListcell else { return UITableViewCell()}
        
        cell.orgNameLabel.text = orgNameArray[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension OrganizationListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

// TODO: 고반의 PR에서 textField의 publisher가 생기면 교체하도록 하겠습니다

extension UITextField {
    var userInputTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification,
                                             object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap { $0.text }
            .eraseToAnyPublisher()
    }
    
    func addLeftImage() {
        let imageLength = self.frame.height
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageLength , height: imageLength))
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .gray
        
        self.leftView = imageView
        self.leftViewMode = ViewMode.always
    }
}
