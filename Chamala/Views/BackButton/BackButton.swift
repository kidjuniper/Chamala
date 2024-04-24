//
//  BackButton.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import UIKit

class BackButton: UIButton {
    var delegate: BackButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.init(x: 0,
                                      y: 0,
                                      width: 20,
                                      height: 20))
        tintColor = .systemGray
        setBackgroundImage(UIImage(systemName: "xmark"),
                           for: .normal)
        addTarget(self,
                  action: #selector(back),
                  for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func back() {        
        delegate?.back()
    }
}
