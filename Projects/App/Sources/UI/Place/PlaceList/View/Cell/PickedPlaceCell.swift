//
//  PickedPlaceCell.swift
//  App
//
//  Created by 리아 on 2022/10/18.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit

final class PickedPlaceCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var shadowView = ShadowView()
    private lazy var imageView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var menuLabel = UILabel()
    
    // TODO: ViewModel에 옮기기
    private var image = UIImage(.img_zesterthree)
    private var name = "밥스버거스"
    private var menu = "버거"
    
    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayout()
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - UI Function

extension PickedPlaceCell {
    
    func configureUI() {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .orange
        nameLabel.text = name
        menuLabel.text = menu
    }
    
    private func createLayout() {
        contentView.addSubviews([shadowView, nameLabel, menuLabel])
        shadowView.addView(imageView)
        
        shadowView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(shadowView.snp.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(shadowView.snp.bottom).offset(10)
            $0.height.greaterThanOrEqualTo(20)
        }
        
        menuLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.height.greaterThanOrEqualTo(20)
            $0.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - Preview

struct PickedPlaceCellPreview: PreviewProvider {
    
    static var previews: some View {
        PickedPlaceCell().toPreview()
    }

}

// TODO: 추후 수정 예정 (버리 코드 + addView)

public final class ShadowView: UIView {

     private lazy var stackView = UIStackView()

     private lazy var contentView: UIView = {
         $0.backgroundColor = .white
         $0.layer.borderWidth = 2
         $0.layer.cornerRadius = 8
         return $0
     }(UIView())

     private lazy var shadowView: UIView = {
         $0.backgroundColor = .black
         $0.clipsToBounds = true
         $0.layer.cornerRadius = 8
         return $0
     }(UIView())

     override init(frame: CGRect) {
         super.init(frame: frame)
         configureUI()
         createLayout()
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

 }

 extension ShadowView {

     private func configureUI() {

     }
     
     func addView(_ view: UIView) {
         contentView.addSubview(view)
         view.clipsToBounds = true
         view.layer.cornerRadius = 8
         view.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }
     }

     private func createLayout() {
         addSubviews([contentView, shadowView])
         bringSubviewToFront(contentView)

         contentView.snp.makeConstraints {
             $0.edges.equalToSuperview()
         }

         shadowView.snp.makeConstraints {
             $0.leading.equalTo(contentView.snp.leading).offset(-4)
             $0.top.equalTo(contentView.snp.top).offset(4)
             $0.width.equalTo(contentView.snp.width)
             $0.height.equalTo(contentView.snp.height)
         }
     }

 }
