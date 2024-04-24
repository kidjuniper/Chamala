//
//  HomePresenter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation
import UIKit

class HomePresenter: HomePresenterProtocol {
    
    weak var view: HomeViewProtocol!
    var interactor: HomeInteractorProtocol!
    var router: HomeRouterProtocol!
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setUpView()
    }
    
    func presentNext() {
        router.presentGame(mode: .hearSentance)
    }
    
    func presentGamePopUp() {
        view.presentGamePopUP()
    }
    
    func gameButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            router.presentGame(mode: .hearSentance)
        case 1:
            router.presentGame(mode: .translateSentance)
        case 2:
            router.presentGame(mode: .gap)
        default:
            print("unrecognized mode")
        }
    }
}
