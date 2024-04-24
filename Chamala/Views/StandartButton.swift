//
//  StandartButton.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation
import UIKit

class StandartButton: UIButton {
    
    private var backGroundColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 10
        clipsToBounds = true
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setTitle(_ title: String?, 
                           for state: UIControl.State) {
        self.setAttributedTitle(NSAttributedString(string: title ?? "",
                                                   attributes: [NSAttributedString.Key.font : UIFont(name: "Futura Bold",
                                                                                                     size: 18)!,
                                                                NSAttributedString.Key.strokeColor : UIColor.white.cgColor]),
                                  for: .normal)
        titleLabel?.textColor = .white
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
        backGroundColor = color
        switch color {
        case UIColor(named: "green"):
            setRadiusWithShadow(withColor: UIColor(named: "darkGreen")!)
        case UIColor.systemPurple:
            setRadiusWithShadow(withColor: .purple)
        case UIColor(named: "blue"):
            setRadiusWithShadow(withColor: UIColor(named: "darkBlue")!)
        case .systemGray:
            setRadiusWithShadow(withColor: .darkGray)
        default:
            break
        }
        
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                if backgroundColor != .clear {
                    backgroundColor = .systemGray
                    setRadiusWithShadow(withColor: .darkGray)
                }
            }
            else {
                backgroundColor = backGroundColor
                switch backGroundColor {
                case UIColor(named: "green"):
                    setRadiusWithShadow(withColor: UIColor(named: "darkGreen")!)
                case UIColor.systemPurple:
                    setRadiusWithShadow(withColor: .purple)
                case UIColor(named: "blue"):
                    setRadiusWithShadow(withColor: UIColor(named: "darkBlue")!)
                case .systemGray:
                    setRadiusWithShadow(withColor: .darkGray)
                default:
                    setRadiusWithShadow(withColor: .clear)
                }
            }
        }
    }
}
