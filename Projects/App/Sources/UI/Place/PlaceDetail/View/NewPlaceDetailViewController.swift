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

final class NewPlaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    private let viewModel = PlaceDetailViewModel()
    private let place: Place = Place.mockData[0]
    private let reviews: [Review] = [Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3], Review.mockData[1], Review.mockData[2], Review.mockData[3]]
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension NewPlaceDetailViewController {
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(PlaceInfoHeaderView.self, forHeaderFooterViewReuseIdentifier: "PlaceInfoHeaderView")
    }
    
    private func createLayout() {
        view.addSubviews([tableView])
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.layoutIfNeeded()
    }
    
}

// MARK: - UITableViewDataSource

extension NewPlaceDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension NewPlaceDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlaceInfoHeaderView") as? PlaceInfoHeaderView else {
            return UIView()
        }
        
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
