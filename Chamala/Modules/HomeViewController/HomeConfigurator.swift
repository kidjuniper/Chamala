//
//  HomeConfigurator.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class HomeConfigurator: HomeConfiguratorProtocol {
    func configure(with viewController: HomeViewController) {
        let presenter = HomePresenter(view: viewController)
        let interactor = HomeInteractor(presenter: presenter)
        let router = HomeRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
