//
//  Shadows.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import UIKit

extension UIView {
    func setRadiusWithShadow(_ radius: CGFloat? = nil,
                             withColor color: UIColor) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0,
                                         height: 3.0)
        layer.borderWidth = 2
        layer.borderColor = color.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
