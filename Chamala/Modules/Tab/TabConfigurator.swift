//
//  TabConfigurator.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class TabConfigurator: TabConfiguratorProtocol {
    func configure(tabBar viewController: TabViewController) {
        let presenter = TabPresenter(view: viewController)
        let interactor = TabInteractor(presenter: presenter)
        let router = TabRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        let submodules = (home: HomeViewController(),
                         profile: ProfileViewController())
        
        let tabs = router.tabs(usingSubodules: submodules)
        viewController.viewControllers = [tabs.home,
                                          tabs.profile]
    }
}
