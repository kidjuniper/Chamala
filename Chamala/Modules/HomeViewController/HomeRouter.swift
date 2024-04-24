//
//  HomeRouter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class HomeRouter: HomeRouterProtocol {
    weak var viewController: HomeViewController!
    
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func presentGame(mode: GameMode) {
        let nextController = HearSentencesGameViewController()
        nextController.mode = mode
        nextController.modalPresentationStyle = .overCurrentContext
        nextController.navigationController?.navigationBar.isHidden = true
        viewController.present(nextController, animated: true)
    }
}
