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
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel = PlaceDetailViewModel()
    private let place: Place = Place.mockData[0]
    private let reviews: [Review] = [Review.mockData[0], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[0], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3]]
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
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
        navigationItem.title = place.name
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
        case false :
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch reviews.count == 0 {
        case true :
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
        header.setUp(with: Place.mockData[0])
        
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
