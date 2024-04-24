//
//  HearSentencesTaskModel.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation

// сейчас моделей 3, но в перспективе их можно превратить в одну

struct HearSentencesTaskModel { 
    let blocks: [Int : String]
    let rightAnswers: [[Int]]
    let auidioUrl: String
    let rightAnswersString: [String]
}
