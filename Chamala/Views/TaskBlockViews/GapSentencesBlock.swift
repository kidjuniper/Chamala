//
//  GapSentencesBlock.swift
//  Chamala
//
//  Created by Nikita Stepanov on 07.04.2024.
//

import Foundation
import UIKit

class GapSentencesBlock: UIView,
                         GapSentencesBlockView {

    var blockDelegate: GapSentencesBlockDelegate?
    
    var buttons: PopUp = PopUp()
    
    var selected = -1 
    {
        didSet {
            buttons.buttons.forEach { b in
                b.setBackgroundColor(UIColor.systemPurple)
            }
            buttons.buttons[selected].setBackgroundColor(UIColor(named: "blue")!)  
        }
    }
    
    var sentancesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collection = UICollectionView(frame: CGRect.zero,
                                           collectionViewLayout: layout)
        collection.isUserInteractionEnabled = true
        collection.isMultipleTouchEnabled = true
        collection.backgroundColor = .clear
        collection.bounces = false
        collection.isScrollEnabled = false
        collection.clipsToBounds = false
        collection.tag = 13
        collection.allowsSelection = true
        return collection
    }()
    
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    func updateCollectionViewsData() {
        sentancesCollection.reloadData()
        sentancesCollection.reloadData()
    }
    
    func selectButton(_ number: Int) {
        selected = number
    }
    
    func setUp(withDelegate: any GapSentencesBlockDelegate) {
        addSubview(mainStack)
        sentancesCollection.register(ClickableWordCollectionCell.self,
                                            forCellWithReuseIdentifier: "id")
        NSLayoutConstraint.activate([mainStack.topAnchor.constraint(equalTo: topAnchor),
                                     mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     mainStack.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                      constant: 10)])
        
        mainStack.addArrangedSubviews(sentancesCollection,
                                      buttons)
        
        NSLayoutConstraint.activate([buttons.heightAnchor.constraint(equalToConstant: 210),
                                     buttons.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor)])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        sentancesCollection.delegate = withDelegate
        buttons.delegate = withDelegate
        sentancesCollection.dataSource = withDelegate
    }
    
    func setUpButtons(withOption option: [String]) {
        buttons.createButtonsWithTitles(with: option)
        buttons.wideLayout()
        buttons.buttons.forEach { b in
            b.setBackgroundColor(UIColor.systemPurple)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol GapSentencesBlockView {
    func updateCollectionViewsData()
    func setUp(withDelegate: GapSentencesBlockDelegate)
    func setUpButtons(withOption option: [String])
    func selectButton(_ number: Int)
}

protocol GapSentencesBlockDelegate: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout,
                                    PopUpDelegate {
    func setSelfAsDelegate(forBlock block: GapSentencesBlock)
}

