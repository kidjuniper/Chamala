//
//  TranslateSentancesTaskModel.swift
//  Chamala
//
//  Created by Nikita Stepanov on 07.04.2024.
//

import Foundation

struct TranslateSentancesTaskModel { 
    let blocks: [Int : String]
    let rightAnswers: [[Int]]
    let translation: [String]
    let auidioUrl: String
    let rightAnswersString: [String]
}
