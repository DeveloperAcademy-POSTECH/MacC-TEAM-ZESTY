//
//  BannerView.swift
//  App
//
//  Created by 리아 on 2022/10/17.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit
import SnapKit

final class BannerCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setView() {
        let bannerView = BannerView()
        let controller = UIHostingController(rootView: bannerView)
        addSubview(controller.view)
        controller.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

struct BannerView: View {

    @State private var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(0..<4) { index in
                Text("\(index)")
                    .tag(index)
                    .tabItem {
                        Image(systemName: (selected == index ? "circle.fill" : "circle"))
                            .environment(\.symbolVariants, .none)
                    }
            }
        }
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = .black
        }
        .tabViewStyle(PageTabViewStyle())
        
    }
    
}

struct BannerCellPreview: PreviewProvider {
    
    static var previews: some View {
        BannerCell().toPreview()
    }

}
