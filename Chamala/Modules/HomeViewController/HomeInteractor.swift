//
//  HomeInteractor.swift
//  Chamala
//
//  Created by Nikita Stepanov on 02.04.2024.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol!
    
    required init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
    }
}
