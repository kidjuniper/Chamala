//
//  HomeProtocols.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    func setUpView()
    func presentGamePopUP()
}

protocol HomePresenterProtocol: AnyObject {
    var router: HomeRouterProtocol! { set get }
    func configureView()
    func presentNext()
    func presentGamePopUp()
    func gameButtonPressed(_ sender: UIButton)
//    func showInternetErrorPopUp() - for future
}

protocol HomeInteractorProtocol: AnyObject {

}

protocol HomeRouterProtocol: AnyObject {
    func presentGame(mode: GameMode)
}

protocol HomeConfiguratorProtocol: AnyObject {
    func configure(with viewController: HomeViewController)
}
