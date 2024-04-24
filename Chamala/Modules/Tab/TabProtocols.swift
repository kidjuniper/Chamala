//
//  TabViewControllerProtocols.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

protocol TabViewProtocol: AnyObject {
   func setUpTabBarApperance()
}

protocol TabPresenterProtocol: AnyObject {
    var router: TabRouterProtocol! { set get }
    func configureView()
//    func showInternetErrorPopUp() - for future
}

protocol TabInteractorProtocol: AnyObject {
    // here will be some stuff for logging in
}

protocol TabRouterProtocol: AnyObject {
    func presentLoginIfNeeded()
}

protocol TabConfiguratorProtocol: AnyObject {
    func configure(tabBar viewController: TabViewController)
}
