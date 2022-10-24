//
//  BannerSubview.swift
//  App
//
//  Created by 리아 on 2022/10/19.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI

struct BannerSubview: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .offset(x: -3, y: 3)
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .foregroundColor(.white)
                .padding(6)
            Image(uiImage: UIImage(.img_zesterthree) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(50)
        }
        .padding(.horizontal, 20)
    }
}

struct BannerSubview_Previews: PreviewProvider {
    static var previews: some View {
        BannerSubview()
    }
}
