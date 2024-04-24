//
//  TabInteractor.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class TabInteractor: TabInteractorProtocol {
    
    weak var presenter: TabPresenterProtocol!
    
    required init(presenter: TabPresenterProtocol) {
        self.presenter = presenter
    }
}
