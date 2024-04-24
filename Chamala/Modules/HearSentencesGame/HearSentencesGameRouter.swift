//
//  HearSentencesGameRouter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

class HearSentencesGameRouter: HearSentencesGameRouterProtocol {

    func back() {
        viewController.dismiss(animated: true)
    }
    
    weak var viewController: HearSentencesGameViewController!
    
    init(viewController: HearSentencesGameViewController) {
        self.viewController = viewController
    }
}
