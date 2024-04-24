//
//  ViewController.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import UIKit

typealias Tabs = (
    home: UIViewController,
    profile: UIViewController
)

final class TabViewController: UITabBarController {
    
    var presenter: TabPresenterProtocol!
    let configurator: TabConfiguratorProtocol = TabConfigurator()
    
    var tabs: Tabs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(tabBar: self)
        presenter.configureView()
    }
}


extension TabViewController: TabViewProtocol {
    func setUpTabBarApperance() {
        tabBar.backgroundColor = .white
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white.withAlphaComponent(0.8)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
    }
}



