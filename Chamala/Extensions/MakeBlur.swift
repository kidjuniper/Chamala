//
//  MakeBlur.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import UIKit

extension UIView {
    func makeBlur() {
        let blurEffectView = UIVisualEffectView(effect: nil)
        
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 91
        blurEffectView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight]
        UIView.animate(withDuration: 0.3) {
            blurEffectView.effect = UIBlurEffect(style: .light)
        }
        
        self.addSubview(blurEffectView)
    }
    
    func removeBlur() {
        self.subviews.forEach { subView in
            if subView.tag == 91 {
                UIView.animate(withDuration: 0.3) {
                    subView.layer.opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    subView.removeFromSuperview()
                }
            }
        }
    }
}
