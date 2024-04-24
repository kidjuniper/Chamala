//
//  TaskProvider.swift
//  Chamala
//
//  Created by Nikita Stepanov on 03.04.2024.
//

import Foundation
import LoremSwiftum

final class TaskProvider {
    func provideHearSentencesTask() -> [HearSentencesTaskModel] {
        var sample: [HearSentencesTaskModel] = []
        for _ in 0..<7 {
            var blocks: [Int : String] = [:]
            var counter = 0
            let sentance = Lorem.sentence
            for _ in sentance.split(separator: " ") {
                if counter < 11 {
                    blocks.updateValue(Lorem.word,
                                       forKey: counter)
                }
                counter += 1
            }
            
            
            let sampleOne = HearSentencesTaskModel(blocks: blocks,
                                                   rightAnswers: [[0,
                                                                   1,
                                                                   2]],
                                                   auidioUrl: "",
                                                   rightAnswersString: ["\(blocks[0]!) \(blocks[1]!) \(blocks[2]!)"])
            sample.append(sampleOne)
        }
        return sample
    }
    
    func provideTranslateSentancesTask() -> [TranslateSentancesTaskModel] {
        var sample: [TranslateSentancesTaskModel] = []
        for _ in 0..<7 {
            var blocks: [Int : String] = [:]
            var translation: [String] = []
            var counter = 0
            let sentance = Lorem.sentence
            for _ in sentance.split(separator: " ") {
                if counter < 10 {
                    blocks.updateValue(Lorem.word,
                                       forKey: counter)
                    translation.append(Lorem.word)
                }
                counter += 1
            }
            
            
            let sampleOne = TranslateSentancesTaskModel(blocks: blocks,
                                                   rightAnswers: [[0,
                                                                   1,
                                                                   2]],
                                                        translation: translation,
                                                   auidioUrl: "",
                                                   rightAnswersString: ["\(blocks[0]!) \(blocks[1]!) \(blocks[2]!)"])
            sample.append(sampleOne)
        }
        return sample
    }
    
    func provideFillTheGapTask() -> [FillTheGapTaskModel] {
        var sample: [FillTheGapTaskModel] = []
        for _ in 0..<7 {
            var words: [String] = []
            var counter = 0
            let sentance = Lorem.sentence
            for _ in sentance.split(separator: " ") {
                if counter < 11 {
                    words.append(Lorem.word)
                }
                counter += 1
            }
            let sampleOne = FillTheGapTaskModel(rightAnswer: Int.random(in: 0...2), 
                                                gaps: [Int.random(in: 0..<words.count/2), Int.random(in: words.count/2...words.count)],
                                                options: [[Lorem.word,
                                                           Lorem.word],
                                                          [Lorem.word,
                                                                     Lorem.word],
                                                          [Lorem.word,
                                                                     Lorem.word]],
                                                words: words,
                                                translation: sentance, 
                                                rightAnswersString: ["\(words[0]) \(words[1]) \(words[2])"])
            sample.append(sampleOne)
        }
        return sample
    }
}
