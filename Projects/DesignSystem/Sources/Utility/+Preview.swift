//
//  +Preview.swift
//  DesignSystem
//
//  Created by 리아 on 2022/10/16.
//  Copyright © 2022 zesty. All rights reserved.
//

import SwiftUI
import UIKit

extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {

        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }

    }

    /// preview를 제공하는 함수
    ///
    /// ```swift
    /// struct ExViewControllerPreview: PreviewProvider {
    ///
    ///     static var previews: some View {
    ///         ExViewController().toPreview()
    ///     }
    ///
    /// }
    /// ```

    public func toPreview() -> some View {
        Preview(viewController: self)
    }

}

extension UIView {

    private struct Preview: UIViewRepresentable {

        let view: UIView

        func makeUIView(context: Context) -> some UIView {
            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
        }

    }
    
    /// preview를 제공하는 함수
    ///
    /// ```swift
    /// struct ExViewPreview: PreviewProvider {
    ///
    ///     static var previews: some View {
    ///         ExView().toPreview()
    ///     }
    ///
    /// }
    /// ```

    public func toPreview() -> some View {
        Preview(view: self)
    }

}
