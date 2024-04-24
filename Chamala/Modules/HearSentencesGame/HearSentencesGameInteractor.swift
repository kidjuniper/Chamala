//
//  HearSentencesGameInteractor.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

class HearSentencesGameInteractor: HearSentencesGameInteractorProtocol {
    
    weak var presenter: HearSentencesGamePresenterProtocol!
    
    required init(presenter: HearSentencesGamePresenterProtocol) {
        self.presenter = presenter
    }
    
    func requestTasksHearSentance() -> [HearSentencesTaskModel] {
        return TaskProvider().provideHearSentencesTask()
    }
    
    func requestTaskTranslateSentances() -> [TranslateSentancesTaskModel] {
        return TaskProvider().provideTranslateSentancesTask()
    }
    
    func requestTasksFillTheGap() -> [FillTheGapTaskModel] {
        return TaskProvider().provideFillTheGapTask()
    }
}
