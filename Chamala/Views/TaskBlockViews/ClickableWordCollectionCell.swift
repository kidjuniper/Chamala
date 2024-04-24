//
//  ClickableWordBoxCollectionCell.swift
//  Chamala
//
//  Created by Nikita Stepanov on 07.04.2024.
//

import Foundation
import UIKit

class ClickableWordCollectionCell: UICollectionViewCell {
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura",
                            size: 12)
        label.tag = 41
        label.textColor = .white
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.tag = 42
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configurate(cellData: ClickableCellData) {
        tag = cellData.tag
        backgroundColor = .clear
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDot.union(.single).rawValue,
                                  NSAttributedString.Key.underlineColor: UIColor.black,
                                  NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.patternDot.rawValue)] as [NSAttributedString.Key : Any]
        
        let attributedString = NSAttributedString(string: "\(cellData.word)",
                                                  attributes: underlineAttribute)
        wordLabel.attributedText = attributedString
        switch cellData.state {
        case .gap:
            wordLabel.textColor = .clear
            setBottomLine()
        case .inputed:
            wordLabel.textColor = UIColor(named: "green")
            lineView.removeFromSuperview()
        case .standart:
            wordLabel.textColor = .systemGray
            lineView.removeFromSuperview()
        }
    }
    
    func setBottomLine() {
        addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalTo: widthAnchor,
                                            constant: 0.9),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    
    func generateWidth() -> CGFloat {
        return CGFloat(max(15,
                           (wordLabel.text?.count ?? 0) * 7 + (wordLabel.textColor == .green ? 15 : 5)))
    }
}
    

struct ClickableCellData {
    var tag: Int
    var word: String
    var width: CGFloat
    var info: String?
    var state: ClickableCellState
}

protocol ClickableWordCollectionCellProtocol {
    func set(object: CellData)
}

enum ClickableCellState {
    case gap
    case inputed
    case standart
}
