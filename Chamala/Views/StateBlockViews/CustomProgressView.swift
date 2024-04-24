//
//  CustomProgressView.swift
//  Chamala
//
//  Created by Nikita Stepanov on 05.04.2024.
//

import Foundation
import UIKit

class CustomProgressView: UIView,
                          CustomProgressViewProtocol {
    func setUp(withDelegate: any CustomProgressViewDelegate) {
        addSubview(mainStack)
        mainCollection.register(CustomProgressViewCell.self,
                                            forCellWithReuseIdentifier: "id")
        NSLayoutConstraint.activate([mainStack.topAnchor.constraint(equalTo: topAnchor),
                                     mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)])
        mainStack.addArrangedSubviews(mainCollection)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainCollection.delegate = withDelegate
        mainCollection.dataSource = withDelegate
    }
    

    var blockDelegate: CustomProgressViewDelegate?
    
    var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collection = UICollectionView(frame: CGRect.zero,
                                           collectionViewLayout: layout)
        collection.isUserInteractionEnabled = true
        collection.isMultipleTouchEnabled = true
        collection.backgroundColor = .clear
        collection.isScrollEnabled = false
        collection.clipsToBounds = false
        collection.tag = 15
        collection.allowsSelection = false
        return collection
    }()
    
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    func updateCollectionViewsData() {
        mainCollection.reloadData()
        mainCollection.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CustomProgressViewProtocol {
    func updateCollectionViewsData()
    func setUp(withDelegate: CustomProgressViewDelegate)
}

protocol CustomProgressViewDelegate: UICollectionViewDelegate,
                                             UICollectionViewDataSource,
                                             UICollectionViewDelegateFlowLayout {
    func setSelfAsDelegate(forBlock block: CustomProgressView)
}


class CustomProgressViewCell: UICollectionViewCell {
    let flareView: UIView = {
        let view = UIView()
        view.tag = 42
        view.layer.cornerRadius = 1.5
        view.backgroundColor = UIColor(named: "progressGreenFlare")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layer.cornerRadius = 3
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(flareView)
        flareView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            flareView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: 2),
            flareView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                               constant: -2),
            flareView.centerXAnchor.constraint(equalTo: centerXAnchor),
            flareView.topAnchor.constraint(equalTo: topAnchor,
                                           constant: 1),
            flareView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    
    func configurate(cellData: ProgressCellData) {
        tag = cellData.tag
        switch cellData.state {
        case .gap:
            backgroundColor = .systemGray
            flareView.isHidden = true
        case .filled:
            backgroundColor = UIColor(named: "progressGreen")
            flareView.isHidden = false
        }
    }
}

struct ProgressCellData {
    var tag: Int
    var state: ProgressCellState
}

enum ProgressCellState {
    case filled
    case gap
}
