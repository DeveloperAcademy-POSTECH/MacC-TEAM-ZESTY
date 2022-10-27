//
//  AddCategoryViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/24.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import DesignSystem
import SnapKit
import Kingfisher

final class AddCategoryViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AddPlaceViewModel
    private var cancelBag = Set<AnyCancellable>()
    private let input: PassthroughSubject<AddPlaceViewModel.Input, Never> = .init()
    
    private var place: Place?
    private var reviews: [Review] = []
    private var categories: [Category] = []
    
    private var selectedIcon: String = ""
    
    private lazy var titleView = MainTitleView(title: "선택한 맛집에서는\n무엇을 먹을 수 있나요?")
    
    private lazy var categoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollecionViewLayout())
    
    private lazy var addPlaceButton: FullWidthBlackButton = {
        $0.setTitle("맛집 등록하기", for: .normal)
        $0.addTarget(self, action: #selector(addPlaceButtonDidTap), for: .touchUpInside)
        return $0
    }(FullWidthBlackButton(state: false))
    
    // MARK: - LifeCycle
    
    init(viewModel: AddPlaceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.send(.categoryViewDidLoad)
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addPlaceButtonDidTap() {
        input.send(.addPlaceBtnDidTap)
    }
    
}

// MARK: - Binding
extension AddCategoryViewController {
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .fetchCategoriesFail(let error):
                    print(error.localizedDescription)
                case .fetchCategoriesDidSucceed(let categories):
                    self?.categories = categories
                    self?.categoryCollectionView.reloadData()
                case .categoryCellSelected:
//                    self?.addPlaceButton.isEnabled = true
                    self?.addPlaceButton.setButtonState(true)
                case .addPlaceFail(let error):
                    print(error.localizedDescription)
                case .addPlaceDidSucceed(let place):
                    let viewModel = AddPlaceResultViewModel(place: place)
                    self?.navigationController?.pushViewController(AddPlaceResultViewController(viewModel: viewModel), animated: true)
                }
            }.store(in: &cancelBag)
    }

}

// MARK: - UI Function

extension AddCategoryViewController {
    
    private func configureUI() {
        setNavigationBar()
        
        view.backgroundColor = .white // zestyColor(.backgroundColor)
        categoryCollectionView.register(CategoryIconCell.self, forCellWithReuseIdentifier: "CategoryIconCell")
        categoryCollectionView.isScrollEnabled = false
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    private func createLayout() {
        view.addSubviews([titleView, categoryCollectionView, addPlaceButton])
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.bottom.equalTo(addPlaceButton.snp.top).offset(-20)
        }
        
        addPlaceButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
    }
    
    private func setNavigationBar() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

/*
// MARK: - Previews

 struct AddCategoryPreview: PreviewProvider {
    
    static var previews: some View {
        AddCategoryViewController().toPreview()
    }
    
}
*/

// MARK: - CollectionView

extension AddCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func createCollecionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = CGFloat(0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryIconCell", for: indexPath) as? CategoryIconCell else { return UICollectionViewCell() }
        cell.configure(with: categories[indexPath.row], viewModel: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIcon = categories[indexPath.row].name
    }
    
}
