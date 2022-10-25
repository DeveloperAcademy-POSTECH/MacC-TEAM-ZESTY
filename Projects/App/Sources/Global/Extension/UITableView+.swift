//
//  UITableView+.swift
//  App
//
//  Created by Chanhee Jeong on 2022/10/25.
//  Copyright © 2022 zesty. All rights reserved.
//

import UIKit
import DesignSystem

extension UITableView {
    
    enum EmptyViewType {
        case search
        case noresult
    }
    
    func setEmptyView(message: String, type: EmptyViewType) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x,
                                             y: self.center.y,
                                             width: self.bounds.size.width,
                                             height: self.bounds.size.height))
           
        let iconView: UIImageView = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.image = UIImage((type == .search) ?  .img_emptyfriends_search : .img_emptyfriends_noresult)
            $0.layer.applyFigmaShadow(
                color: .black,
                opacity: 0.1,
                xCoord: 0,
                yCoord: 0,
                blur: 5,
                spread: 0
            )
            return $0
        }(UIImageView())
        
        let messageLabel: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = message
            $0.textColor = (type == .noresult) ? .zestyColor(.dim) : .label
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 17, weight: .medium)
            $0.sizeToFit()
            return $0
        }(UILabel())
        
        self.addSubview(emptyView)
        
        emptyView.addSubviews([iconView, messageLabel])
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -180),
            iconView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 50),
            iconView.heightAnchor.constraint(equalToConstant: 50),
            messageLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20)
        ])
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
