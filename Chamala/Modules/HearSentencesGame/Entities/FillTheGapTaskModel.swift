//
//  FillTheGapTaskModel.swift
//  Chamala
//
//  Created by Nikita Stepanov on 07.04.2024.
//

import Foundation

struct FillTheGapTaskModel {
    let rightAnswer: Int
    let gaps: [Int]
    let options: [[String]]
    let words: [String]
    let translation: String
    let rightAnswersString: [String]
}
