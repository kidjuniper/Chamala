//
//  WordBlocksCollectionsBlock.swift
//  Chamala
//
//  Created by Nikita Stepanov on 06.04.2024.
//

import Foundation
import UIKit

class WordBlocksCollectionsBlock: UIView,
                                  WordBlocksCollectionsBlockView {
    
    var delegate: UICollectionViewDelegate?
    var dataSource: UICollectionViewDataSource?
    var flowLayoutDelegate: UICollectionViewDelegateFlowLayout?
    var blockDelegate: WordBlocksCollectionsBlockDelegate?
    
    var collectionViewSelected: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collection = UICollectionView(frame: CGRect.zero,
                                           collectionViewLayout: layout)
        collection.isUserInteractionEnabled = true
        collection.isMultipleTouchEnabled = true
        collection.backgroundColor = .clear
        collection.bounces = false // на будущее, чтобы сделать единую коллекцию
        collection.isScrollEnabled = false
        collection.clipsToBounds = false
        collection.tag = 10
        collection.allowsSelection = true
        return collection
    }()
    
    var collectionViewWaiting: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collection = UICollectionView(frame: CGRect.zero,
                                           collectionViewLayout: layout)
        collection.isUserInteractionEnabled = true
        collection.backgroundColor = .clear
        collection.bounces = false
        collection.isMultipleTouchEnabled = true
        collection.isScrollEnabled = false
        collection.tag = 11
        collection.allowsSelection = true
        return collection
    }()
    
    var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(withDelegate: WordBlocksCollectionsBlockDelegate) {
        addSubview(mainStack)
        collectionViewWaiting.register(WordBoxCollectionCell.self,
                                            forCellWithReuseIdentifier: "id")
        collectionViewSelected.register(WordBoxCollectionCell.self,
                                        forCellWithReuseIdentifier: "id")
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([mainStack.topAnchor.constraint(equalTo: topAnchor),
                                     mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)])
        mainStack.addArrangedSubviews(collectionViewSelected,
                                      collectionViewWaiting)
        let pressGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePressGesture)
        )
        collectionViewSelected.addGestureRecognizer(pressGesture)
        setDelegate(delegate: withDelegate)
        setDataSource(dataSource: withDelegate)
        setflowLayoutDelegate(delegate: withDelegate)
    }
    
    func setDelegate(delegate: any UICollectionViewDelegate) {
        self.delegate = delegate
        collectionViewWaiting.delegate = self.delegate
        collectionViewSelected.delegate = self.delegate
    }
    
    func setDataSource(dataSource: any UICollectionViewDataSource) {
        self.dataSource = dataSource
        collectionViewWaiting.dataSource = self.dataSource
        collectionViewSelected.dataSource = self.dataSource
    }
    
    func setflowLayoutDelegate(delegate: any UICollectionViewDelegateFlowLayout) {
        flowLayoutDelegate = delegate
    }
    
    func updateCollectionViewsData() {
        collectionViewSelected.reloadData()
        collectionViewWaiting.reloadData()
    }
    
    @objc private func handlePressGesture(_ gesture: UIPanGestureRecognizer) {
        let gestureLocation = gesture.location(in: collectionViewSelected)
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionViewSelected.indexPathForItem(at: gestureLocation) else {
                return
            }
            collectionViewSelected.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionViewSelected.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionViewSelected.endInteractiveMovement()
        default:
            collectionViewSelected.cancelInteractiveMovement()
        }
    }
}


protocol WordBlocksCollectionsBlockView {
    func updateCollectionViewsData()
    func setDelegate(delegate: UICollectionViewDelegate)
    func setDataSource(dataSource: UICollectionViewDataSource)
    func setflowLayoutDelegate(delegate: UICollectionViewDelegateFlowLayout)
    func setUp(withDelegate: WordBlocksCollectionsBlockDelegate)
}


protocol WordBlocksCollectionsBlockDelegate: UICollectionViewDelegate,
                                             UICollectionViewDataSource,
                                             UICollectionViewDelegateFlowLayout {
    func setSelfAsDelegate(forBlock block: WordBlocksCollectionsBlockView)
}
