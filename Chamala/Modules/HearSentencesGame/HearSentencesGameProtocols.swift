//
//  HearSentencesGameProtocols.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

protocol HearSentencesGameViewProtocol: AnyObject {
    func setUpView()
    func returnWidth() -> CGFloat
    func presentCheck(_ isRight: Bool,
                      rightAnswer: String)
    func updateCollectionViewAppearance(with data: [[CellData]])
    func updateCollectionViewAppearance(with data: [ClickableCellData])
    func updateCollectionViewAppearance(with data: [ClickableCellData],
                                        options: [String])
    func nextTask()
}

protocol HearSentencesGamePresenterProtocol: AnyObject {
    var router: HearSentencesGameRouterProtocol! { set get }
    func configureView(mode: GameMode)
    func presentTask(gameMode mode: GameMode)
    func back()
    func nextTask()
    func presentResults(answer: [Int],
                        gameMode mode: GameMode)
}

protocol HearSentencesGameInteractorProtocol: AnyObject {
    func requestTasksHearSentance() -> [HearSentencesTaskModel]
    func requestTaskTranslateSentances() -> [TranslateSentancesTaskModel]
    func requestTasksFillTheGap() -> [FillTheGapTaskModel]
}

protocol HearSentencesGameRouterProtocol: AnyObject {
    func back()
}

protocol HearSentencesGameConfiguratorProtocol: AnyObject {
    func configure(HearSentencesGameBar viewController: HearSentencesGameViewController)
}
