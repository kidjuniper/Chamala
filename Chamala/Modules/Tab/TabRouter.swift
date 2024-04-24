//
//  TabRouter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import UIKit

class TabRouter: TabRouterProtocol {
    
    weak var viewController: TabViewController!
    
    typealias Submodules = (
        home: UIViewController,
        profile: UIViewController
    )
    
    init(viewController: TabViewController) {
        self.viewController = viewController
    }
    
    func presentLoginIfNeeded() {
//        viewController.present(TabViewController(),
//                               animated: true)
    }
}

extension TabRouter {
    func tabs(usingSubodules submodules: Submodules) -> Tabs {
        let homeTabBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house"), 
                                          tag: 0)
        let gameTabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person"),
                                          tag: 1)
        submodules.home.tabBarItem = homeTabBarItem
        submodules.profile.tabBarItem = gameTabBarItem
        
        return (home: submodules.home,
                profile: submodules.profile)
    }
}
