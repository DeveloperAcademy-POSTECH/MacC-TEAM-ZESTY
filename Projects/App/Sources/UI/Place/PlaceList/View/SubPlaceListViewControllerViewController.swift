//
//  SubPlaceListViewControllerViewController.swift
//  App
//
//  Created by 김태호 on 2022/10/25.
//  Copyright (c) 2022 zesty. All rights reserved.
//

import Combine
import UIKit
import SnapKit

final class SubPlaceListViewControllerViewController: UIViewController {
    
    // MARK: - Properties
    private let cancelBag = Set<AnyCancellable>()
    private let tableView = UITableView()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: - Function
    
}

// MARK: - UI Function

extension SubPlaceListViewControllerViewController {
    
    private func configureUI() {
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.register(WholePlaceCell.self, forCellReuseIdentifier: WholePlaceCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
    }
    
    private func createLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension SubPlaceListViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WholePlaceCell.identifier, for: indexPath) as? WholePlaceCell
        guard let cell = cell else { return UITableViewCell() }
        
        return cell
    }
}

extension SubPlaceListViewControllerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Previews
import SwiftUI

struct SubPlaceListViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        SubPlaceListViewControllerViewController().toPreview()
    }
    
}
