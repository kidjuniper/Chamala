//
//  HearSentencesGameConfigurator.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

class HearSentencesGameConfigurator: HearSentencesGameConfiguratorProtocol {
    
    func configure(HearSentencesGameBar viewController: HearSentencesGameViewController) {
        let presenter = HearSentencesGamePresenter(view: viewController)
        let interactor = HearSentencesGameInteractor(presenter: presenter)
        let router = HearSentencesGameRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
