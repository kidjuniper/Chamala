//
//  HearSentencesGamePresenter.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

class HearSentencesGamePresenter: HearSentencesGamePresenterProtocol {
    
    weak var view: HearSentencesGameViewProtocol!
    var interactor: HearSentencesGameInteractorProtocol!
    var router: HearSentencesGameRouterProtocol!
    
    var sessionTasksHearSentance: [HearSentencesTaskModel] = []
    var sessionTasksTranslateSentance: [TranslateSentancesTaskModel] = []
    var sessionTasksGap: [FillTheGapTaskModel] = []
    
    var cells: [[CellData]] = [[], []]
    var translations: [ClickableCellData] = []
    var sentances: [ClickableCellData] = []
    var options: [String] = []
    var selectedTask = -1
    
    required init(view: HearSentencesGameViewProtocol) {
        self.view = view
    }
    
    func configureView(mode: GameMode) {
        loadTask(forMode: mode)
        view.setUpView()
    }
    
    func loadTask(forMode mode: GameMode) {
        switch mode {
        case .hearSentance:
            sessionTasksHearSentance = interactor.requestTasksHearSentance()
        case .translateSentance:
            sessionTasksTranslateSentance = interactor.requestTaskTranslateSentances()
        case .gap:
            sessionTasksGap = interactor.requestTasksFillTheGap()
        case .hear:
            break
        }
    }
    
    func nextTask() {
        selectedTask += 1
    }
    
    func presentResults(answer: [Int],
                        gameMode mode: GameMode) {
        switch mode {
        case .hearSentance:
            view.presentCheck(sessionTasksHearSentance[selectedTask].rightAnswers.contains(answer),
                              rightAnswer: sessionTasksHearSentance[selectedTask].rightAnswersString.first!)
        case .translateSentance:
            view.presentCheck(sessionTasksTranslateSentance[selectedTask].rightAnswers.contains(answer),
                              rightAnswer: sessionTasksTranslateSentance[selectedTask].rightAnswersString.first!)
        case .gap:   
            for i in 0..<sessionTasksGap[selectedTask].gaps.count {
                sentances.remove(at: sessionTasksGap[selectedTask].gaps[i])
                let word = sessionTasksGap[selectedTask].options[answer.first!][i]
                sentances.insert(ClickableCellData(tag: 0,
                                                   word: word,
                                                   width: word.generateWidthMedium(),
                                                   state: .inputed),
                                 at: sessionTasksGap[selectedTask].gaps[i])
            }
            view.updateCollectionViewAppearance(with: sentances)
            view.presentCheck(sessionTasksGap[selectedTask].rightAnswer == answer.first ?? -1,
                              rightAnswer: sessionTasksGap[selectedTask].rightAnswersString.first!)
        case .hear:
            break
        }
    }
    
    func usedCellWithTag(tag: Int) {
        
    }
    
    func presentTask(gameMode mode: GameMode) {
        view.nextTask()
        nextTask()
        cells = [[], []]
        translations = []
        sentances = []
        options = []
        switch mode {
        case .hearSentance:
            var row = 1
            var summ = 0.0
            for i in sessionTasksHearSentance[selectedTask].blocks {
                let cell = CellData(tag: i.key,
                                    word: i.value,
                                    width: i.value.generateWidth())
                if (summ + i.value.generateWidth()) < (view.returnWidth() - 64.0) {
                    summ += max(20.0, Double(i.value.count) * 9.0 + 7.0) + 10.0
                    cells[row].append(cell)
                }
                else {
                    cells.append([])
                    row += 1
                    summ = 0
                }
            }
            view.updateCollectionViewAppearance(with: cells)
            
        case .translateSentance:
            var row = 1
            var summ = 0.0
            for i in sessionTasksTranslateSentance[selectedTask].blocks {
 
                let cell = CellData(tag: i.key,
                                    word: i.value,
                                    width: i.value.generateWidth())
                if (summ + i.value.generateWidth()) < (view.returnWidth() - 64.0) {
                    summ += max(20.0, Double(i.value.count) * 9.0 + 7.0) + 10.0
                    cells[row].append(cell)
                }
                else {
                    cells.append([])
                    row += 1
                    summ = 0
                }
            }
            for i in sessionTasksTranslateSentance[selectedTask].translation {
                let translation = ClickableCellData(tag: 0,
                                                    word: i,
                                                    width: i.generateWidthSmall(),
                                                    state: .standart)
                translations.append(translation)
            }
            view.updateCollectionViewAppearance(with: translations)
            view.updateCollectionViewAppearance(with: cells)
        case .gap:
            for i in sessionTasksGap[selectedTask].words {
                let sentance = ClickableCellData(tag: 0,
                                                 word: i,
                                                    width: i.generateWidthMedium(),
                                                    state: .standart)
                sentances.append(sentance)
            }
            
            for i in sessionTasksGap[selectedTask].gaps {
                sentances.insert(ClickableCellData(tag: 0,
                                                   word: "",
                                                      width: 100,
                                                   state: .gap),
                                 at: i)
            }
            var ops: [String] = []
            for i in sessionTasksGap[selectedTask].options {
                ops.append("\(i.first!)...\(i.last!)")
            }
            view.updateCollectionViewAppearance(with: sentances,
                                                options: ops)
        case .hear:
            break
        }
    }
    
    func back() {
        router.back()
    }
}
