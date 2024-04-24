//
//  PresentPopUp.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import UIKit

extension UIView {
    func presentPopUp(popUp: PopUp,
                      size: PopUpSizes) {
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(removePopUP))
        addGestureRecognizer(gesture)
        makeBlur()
        popUp.tag = 81
        popUp.clipsToBounds = true
        
        addSubview(popUp)
        popUp.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        popUp.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        popUp.translatesAutoresizingMaskIntoConstraints = false
        popUp.widthAnchor.constraint(equalTo: self.widthAnchor,
                                     multiplier: 0.9).isActive = true
        switch size {
        case .small:
            popUp.heightAnchor.constraint(equalTo: self.widthAnchor,
                                          multiplier: 0.45).isActive = true
        case .medium:
            popUp.heightAnchor.constraint(equalTo: self.widthAnchor,
                                          multiplier: 0.6).isActive = true
        case .big:
            popUp.heightAnchor.constraint(equalTo: self.widthAnchor,
                                          multiplier: 0.85).isActive = true
        }
        popUp.transform = CGAffineTransform(scaleX: 1.35,
                                            y: 1.35)
        popUp.alpha = 0.0
        
        UIView.animate(withDuration: 0.25) {
            popUp.transform = CGAffineTransform(scaleX: 1.0,
                                                y: 1.0)
            popUp.alpha = 1.0
        }
    }
    
    @objc func removePopUP() {
        guard let popUp = viewWithTag(81) as? PopUp else {
            return
        }
        removePopUp(popUp: popUp)
        removeBlur()
    }
    
    func removePopUp(popUp: PopUp,
                     withBlur: Bool = false) {
        self.gestureRecognizers?.removeAll()
        UIView.animate(withDuration: 0.25,
                       animations: {
            popUp.transform = CGAffineTransform(scaleX: 1.35,
                                                y: 1.35)
            popUp.alpha = 0.0
        }) { _ in
            popUp.removeFromSuperview()
        }
    }
}

enum PopUpSizes {
    case small
    case medium
    case big
}

