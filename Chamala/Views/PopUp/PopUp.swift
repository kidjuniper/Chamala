//
//  PopUp.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import UIKit

final class PopUp: UIView, PopUpProtocol {
    
    var delegate: PopUpDelegate?
    
    var buttons: [StandartButton] = []
    
    let popUpStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.insetsLayoutMarginsFromSafeArea = true
        stack.distribution = .fillEqually
        return stack
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 18
        label.textAlignment = .left
        label.font = UIFont(name: "Futura Bold",
                            size: 17)
        label.clipsToBounds = true
        return label
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Futura Bold",
                            size: 15)
        return label
    }()
    
    let rightAnswerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Futura",
                            size: 13)
        return label
    }()
    
    let bgView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    init(rightAnserText: String,
         isRight: Bool) {
        super.init(frame: CGRect.zero)
        baseLayout()
        popUpStack.addArrangedSubviews(topLabel,
                                       answerLabel,
                                       rightAnswerLabel)
        rightAnswerLabel.text = rightAnserText
        switch isRight {
        case false:
            backgroundColor = UIColor(named: "popUpRed")
            bgView.backgroundColor = UIColor(named: "popUpRed")
            bgView.setRadiusWithShadow(withColor: .red)
            topLabel.text = "😭 Wrong"
            answerLabel.text = "Incorrect answer"
        case true:
            backgroundColor = UIColor(named: "popUpGreen")
            bgView.setRadiusWithShadow(withColor: UIColor(named: "darkGreen")!)
            bgView.backgroundColor = UIColor(named: "popUpGreen")
            topLabel.text = "🥳 Right"
            answerLabel.text = "Correct answer"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func baseLayout() {
        layer.cornerRadius = 18
        bgView.layer.cornerRadius = 18
        bgView.clipsToBounds = true
        clipsToBounds = true
        self.addSubview(bgView)
        self.addSubview(popUpStack)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        popUpStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bgView.topAnchor.constraint(equalTo: topAnchor,
                                                                constant: 0),
                                     bgView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     bgView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     bgView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                    constant: -3),
            
            popUpStack.topAnchor.constraint(equalTo: self.topAnchor,
                                                                     constant: 20),
                                     popUpStack.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                        constant: -20),
                                     popUpStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                         constant: 20),
                                     popUpStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                          constant: -20)
        ])
    }
    
    func wideLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        self.addSubview(popUpStack)
        popUpStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([popUpStack.topAnchor.constraint(equalTo: self.topAnchor),
                                     popUpStack.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                       constant: -10),
                                     popUpStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     popUpStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                                    ])
    }
    
    func createButtonsWithTitles(with titles: [String]) {
        buttons = []
        
        for i in popUpStack.subviews {
            popUpStack.removeArrangedSubview(i)
        }
        for i in 0..<titles.count {
            let button = StandartButton()
            button.setBackgroundColor(UIColor(named: "green")!)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(titles[i],
                            for: .normal)
            button.tag = i
            button.addTarget(self,
                             action: #selector(gameButtonPressed(_:)),
                             for: .touchUpInside)
            buttons.append(button)
        }
        buttons.forEach { b in
            popUpStack.addArrangedSubview(b)
        }
    }
    
    @objc func gameButtonPressed(_ sender: UIButton) {
        delegate?.gameButtonPressed(sender)
    }
}
