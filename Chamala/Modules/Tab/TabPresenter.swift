//
//  TabPresenter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class TabPresenter: TabPresenterProtocol {

    weak var view: TabViewProtocol!
    var interactor: TabInteractorProtocol!
    var router: TabRouterProtocol!
    
    required init(view: TabViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setUpTabBarApperance()
    }
}
