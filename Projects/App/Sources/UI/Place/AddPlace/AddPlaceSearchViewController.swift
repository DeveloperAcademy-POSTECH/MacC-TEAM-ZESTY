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
    private let viewModel: AddPlaceSearchViewModel
    private let input: PassthroughSubject<AddPlaceSearchViewModel.Input, Never> = .init()
    private var cancelBag = Set<AnyCancellable>()
    
    private var searchResults: [KakaoPlace] = []
    
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
    init(viewModel: AddPlaceSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureUI()
        createLayout()
        searchingTextFieldView.textField.delegate = self
        searchingTextFieldView.textField.becomeFirstResponder()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonDidTap() {
//        print("검색버튼이 눌렸어요")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchingTextFieldView.textField.resignFirstResponder()
    }
    
}

// MARK: - Binding

extension AddPlaceSearchViewController {
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .serachPlaceFail(let error):
                    print("✅✅✅✅ 결과 가져오는데 실패햇습니다")
                    print(error.localizedDescription)
                case .serachPlaceDidSucceed(let results):
                    self?.searchResults = results
                    print("✅✅✅✅결과 가져오는데 성공햇습니다")
                case .existingPlace:
                    print("✅✅✅✅이미 존재하는 장소입니다.")
                case .addSelectedPlace:
                    print("✅✅✅✅다음페이지로 전환")
                }
            }.store(in: &cancelBag)
        
    }
}

// MARK: - UI Function

extension AddPlaceSearchViewController {
    
    private func configureUI() {
        view.backgroundColor = .white // zestyColor(.backgroundColor)
        tableView.backgroundColor = .white // zestyColor(.backgroundColor)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
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
            make.top.equalTo(searchingTextFieldView.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview()
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

// MARK: - UITableViewDataSource

extension AddPlaceSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            if searchingTextFieldView.textField.text == "" {
                tableView.setEmptyView(message: "등록하려는 맛집을\n검색해주세요.", type: .search)
            } else {
                tableView.setEmptyView(message: "검색 결과가 없어요.", type: .noresult)
            }
        } else {
            tableView.restore()
        }
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultCell else { return UITableViewCell() }
        
        cell.setup(with: searchResults[indexPath.row])
        cell.selectionStyle = .none
        return cell

    }
    
}

// MARK: - UITableViewDelegate
extension AddPlaceSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }

}

// MARK: - UITextFieldDelegate

extension AddPlaceSearchViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        tableView.reloadData()
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
