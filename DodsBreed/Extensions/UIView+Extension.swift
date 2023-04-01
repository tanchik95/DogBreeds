//
//  UIView+Extension.swift
//
//  Created by Татьяна Аникина on 31.03.2023.
//

import UIKit

extension UIView {
    func setRadius(radius: CGFloat) {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}

