//
//  SearchPlaceViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/11/03.
//  Copyright © 2022 com.zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit

final class SearchPlaceViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SearchPlaceViewModel
    private let input: PassthroughSubject<SearchPlaceViewModel.Input, Never> = .init()
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
    init(viewModel: SearchPlaceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureUI()
        createLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func searchButtonDidTap() {
        input.send(.searchBtnDidTap(placeName: searchingTextFieldView.textField.text ?? "" ))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchingTextFieldView.textField.resignFirstResponder()
    }
    
}

// MARK: - Binding

extension SearchPlaceViewController {
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .searchPlaceFail(let error):
                    print(error.localizedDescription)
                case .searchPlaceDidSucceed(let results):
                    self?.searchResults = results
                    self?.tableView.reloadData()
                case .existingPlace:
                    let alert = UIAlertController(title: "등록된 맛집",
                                                  message: "우리 대학에 이미 등록된 맛집이에요.",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(okAction)
                    self?.present(alert, animated: false)
                case .addSelectedPlaceFail(let error):
                    print(error.localizedDescription)
                case .addSelectedPlaceDidSucceed(let kakaoPlace):
                        let viewModel = AddPlaceViewModel(kakaoPlace: kakaoPlace)
                        self?.navigationController?.pushViewController(AddCategoryViewController(viewModel: viewModel), animated: true)
                    
                }
            }.store(in: &cancelBag)
        
    }
}

// MARK: - UI Function

extension SearchPlaceViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        
        setNavigationBar()
        
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        searchingTextFieldView.textField.delegate = self
        searchingTextFieldView.textField.becomeFirstResponder()
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
        navigationItem.title = "맛집검색"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

// MARK: - UITableViewDataSource

extension SearchPlaceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            if searchingTextFieldView.textField.text == "" {
                tableView.setEmptyView(message: "등록된 맛집을\n검색해보세요.", type: .search)
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
        
        cell.bind(with: searchResults[indexPath.row])
        cell.selectionStyle = .none
        return cell

    }
    
}

// MARK: - UITableViewDelegate
extension SearchPlaceViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = searchResults[indexPath.row]
        self.input.send(.placeResultCellDidTap(kakaoPlace: place))
        
    }

}

// MARK: - UITextFieldDelegate

extension SearchPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        input.send(.searchBtnDidTap(placeName: searchingTextFieldView.textField.text ?? "" ))
        return true
    }
    
}

/*
// MARK: - Previews

extension AddPlaceSearchPreview: PreviewProvider {
    
    static var previews: some View {
        SearchPlaceViewController().toPreview()
    }
    
}
*/
