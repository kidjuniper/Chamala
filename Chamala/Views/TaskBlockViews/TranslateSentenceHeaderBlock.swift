//
//  TranslateSentenceHeaderBlock.swift
//  Chamala
//
//  Created by Nikita Stepanov on 06.04.2024.
//

import Foundation
import UIKit

class TranslateSentenceHeaderBlock: UIView,
                                    TranslateSentenceHeaderBlockView {

    var blockDelegate: TranslateSentenceHeaderBlockDelegate?
    
    var tatarBoyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tatarBoy")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var someView = UIView()
    
    var wordCloudCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collection = UICollectionView(frame: CGRect.zero,
                                           collectionViewLayout: layout)
        collection.isUserInteractionEnabled = true
        collection.isMultipleTouchEnabled = true
        collection.backgroundColor = .clear
        collection.layer.borderWidth = 1
        collection.layer.borderColor = UIColor(named: "border")?.cgColor
        collection.layer.cornerRadius = 24
        collection.isScrollEnabled = false
        collection.clipsToBounds = false
        collection.tag = 12
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
        wordCloudCollection.reloadData()
        wordCloudCollection.reloadData()
    }
    
    func setUp(withDelegate: any TranslateSentenceHeaderBlockDelegate) {
        addSubview(mainStack)
        wordCloudCollection.register(ClickableWordCollectionCell.self,
                                            forCellWithReuseIdentifier: "id")
        NSLayoutConstraint.activate([mainStack.topAnchor.constraint(equalTo: topAnchor),
                                     mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)])
        mainStack.addArrangedSubviews(tatarBoyImage,
                                      wordCloudCollection)
        
        NSLayoutConstraint.activate([tatarBoyImage.widthAnchor.constraint(equalTo: heightAnchor,
                                                                          multiplier: 0.9),
                                     tatarBoyImage.heightAnchor.constraint(equalTo: heightAnchor)])
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        wordCloudCollection.delegate = withDelegate
        wordCloudCollection.dataSource = withDelegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol TranslateSentenceHeaderBlockView {
    func updateCollectionViewsData()
    func setUp(withDelegate: TranslateSentenceHeaderBlockDelegate)
}

protocol TranslateSentenceHeaderBlockDelegate: UICollectionViewDelegate,
                                             UICollectionViewDataSource,
                                             UICollectionViewDelegateFlowLayout {
    func setSelfAsDelegate(forBlock block: TranslateSentenceHeaderBlock)
}
