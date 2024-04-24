//
//  CCBeta.swift
//  Chamala
//
//  Created by Nikita Stepanov on 04.04.2024.
//

import Foundation
import UIKit

class WordBoxCollectionCell: UICollectionViewCell {
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura",
                            size: 15)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 10
        contentView.clipsToBounds = true
        backgroundColor = .systemPurple
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(wordLabel)
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configurate(cellData: CellData) {
        tag = cellData.tag
        backgroundColor = .systemPurple
        wordLabel.textColor = .white
        setRadiusWithShadow(withColor: .purple)
        wordLabel.text = cellData.word
    }
    
    func configuratePlug(cellData: CellData) {
        tag = cellData.tag
        setRadiusWithShadow(withColor: .clear)
        backgroundColor = .systemGray
        wordLabel.text = cellData.word
        wordLabel.textColor = .clear
    }
    
    func generateWidth() -> CGFloat {
        return CGFloat(max(20,
                           (wordLabel.text?.count ?? 0) * 9 + 7))
    }
}

extension WordBoxCollectionCell: WordBoxCollectionCellProtocol {
    func set(object: CellData) {
        configurate(cellData: object)
    }
}

struct CellData {
    var tag: Int
    var word: String
    var width: CGFloat
}

protocol WordBoxCollectionCellProtocol {
    func set(object: CellData)
}

extension String {
    func generateWidth() -> CGFloat {
        return CGFloat(max(20,
                           (self.count) * 9 + 7))
    }
}
