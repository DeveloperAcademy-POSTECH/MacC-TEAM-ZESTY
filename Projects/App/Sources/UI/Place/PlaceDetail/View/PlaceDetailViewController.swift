//
//  NewPlaceDetailViewController.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/21.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit
import SwiftUI

final class PlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: PlaceDetailViewModel
    private let input: PassthroughSubject<PlaceDetailViewModel.Input, Never> = .init()
    private var cancelBag = Set<AnyCancellable>()
    
    private var reviews: [Review] = []
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let notification = Notification.Name(rawValue: "addReview")
    
    // MARK: - LifeCycle
    
    init(viewModel: PlaceDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.send(.viewDidLoad)
        createObservers()
        setNavigationBar()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    @objc func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func createObservers() {
       NotificationCenter.default.addObserver(self, selector: #selector(routeToAddReview), name: notification, object: nil)
    }
    @objc func routeToAddReview(notification: NSNotification) {
        let viewModel = ReviewRegisterViewModel(placeId: viewModel.place!.id, placeName: viewModel.place!.name)
        self.navigationController?.pushViewController(EvaluationViewController(viewModel: viewModel), animated: true)
    }
    
}

// MARK: - Binding

extension PlaceDetailViewController {
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                // TO-DO: API 전체 다 붙이고 주석삭제
                case .fetchPlaceDidSucceed(let place):
                    self?.setNavigationBar()
                    self?.navigationItem.title = place.name
                    self?.tableView.reloadData()
                case .fetchPlaceInfoFail(let error):
                    print(error.localizedDescription)
                case .fetchReviewListSucceed(let reviews):
                    self?.reviews = reviews
                    self?.tableView.reloadData()
                case .fetchReviewListFail(let error):
                    self?.reviews = []
                    print(error.localizedDescription)
//                case .routeToReviewAdd(let place):
//                    let viewModel = ReviewRegisterViewModel(placeId: place.id, placeName: place.name)
//                    self?.navigationController?.pushViewController(EvaluationViewController(viewModel: viewModel), animated: true)
//
                }
            }.store(in: &cancelBag)
    }

}

// MARK: - UI Function

extension PlaceDetailViewController {
    
    private func configureUI() {
        tableView.backgroundColor = .zestyColor(.background)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(PlaceInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "PlaceInfoHeaderView")
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        tableView.register(EmptyReviewCell.self, forCellReuseIdentifier: "EmptyReviewCell")
        tableView.separatorStyle = .none
    }
    
    private func createLayout() {
        view.addSubviews([tableView])
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonDidTap))
        leftBarButton.tintColor = .label
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
}

// MARK: - UITableViewDataSource

extension PlaceDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch reviews.count == 0 {
        case true:
            return 1
        case false:
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch reviews.count == 0 {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyReviewCell", for: indexPath)
                    as? EmptyReviewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case false:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath)
                    as? ReviewCell else { return UITableViewCell() }
            cell.setup(with: reviews[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
}

// MARK: - UITableViewDelegate
extension PlaceDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.isWiderThan425pt ? 365 : 330
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.isWiderThan425pt ? 365 : 330
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlaceInfoHeaderView") as? PlaceInfoHeaderView else {
            return UIView()
        }
        header.bind(to: viewModel)
        return header
    }
    
}

/*
 // MARK: - Previews
 
 struct NewPlaceDetailPreview: PreviewProvider {
 
 static var previews: some View {
 NewPlaceDetailViewController().toPreview()
 }
 
 }
 */
