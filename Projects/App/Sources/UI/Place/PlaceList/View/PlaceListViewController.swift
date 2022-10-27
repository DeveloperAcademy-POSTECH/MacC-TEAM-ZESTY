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

// TODO: cell을 실험하기 위한 뷰입니다. 수정 예정입니다.
final class PlaceListViewController: UIViewController {
    
    // MARK: - Properties
    private var cancelBag = Set<AnyCancellable>()
    private let viewModel: PlaceListViewModel
    private let tableView = UITableView()
    
    // MARK: - LifeCycle
    
    init(viewModel: PlaceListViewModel = PlaceListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
        bind()
    }
    
    // MARK: - Function
    
    private func bind() {
        viewModel.$result
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancelBag)
    }

}

extension PlaceListViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.identifier, for: indexPath) as? PlaceCell
        guard let cell = cell else { return UITableViewCell() }
        let place = viewModel.result[indexPath.row]
        cell.setUp(with: place)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let rows = indexPaths.map { $0.row }
        viewModel.prefetch(at: rows)
    }
    
}

extension PlaceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeId = viewModel.result[indexPath.row].id
        let placeDetailViewModel = PlaceDetailViewModel(placeId: placeId)
        show(PlaceDetailViewController(viewModel: placeDetailViewModel), sender: nil)
    }
    
}

// MARK: - UI Function

extension PlaceListViewController {
    
    private func configureUI() {
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
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

// MARK: - Previews

#if DEBUG
import SwiftUI

struct PlaceListViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        PlaceListViewController().toPreview()
    }
    
}
#endif
