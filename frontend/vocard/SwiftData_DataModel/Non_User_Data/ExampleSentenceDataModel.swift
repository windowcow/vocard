//
//  ExampleSentenceDataModel.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import Foundation
import SwiftData

@Model final class ExampleSentenceDataModel {
    var id: UUID
    var sentence: String
    var sentenceInOtherLanguage: [String:String]
    var illustrations: [IllustrationDataModel]
    
    init(id: UUID = UUID(), sentence: String, sentenceInOtherLanguage: [String : String] = [:], illustrations: [IllustrationDataModel] = []) {
        self.id = id
        self.sentence = sentence
        self.sentenceInOtherLanguage = sentenceInOtherLanguage
        self.illustrations = illustrations
    }
}

extension ExampleSentenceDataModel {
    static var samples: [ExampleSentenceDataModel] {
        [
            ExampleSentenceDataModel(sentence: "To go somewhere"),
            ExampleSentenceDataModel(sentence: "The cat sat on the mat"),
            ExampleSentenceDataModel(sentence: "Swift programming is fun and interactive"),
            ExampleSentenceDataModel(sentence: "The sun rises in the east"),
            ExampleSentenceDataModel(sentence: "She loves reading books in her free time"),
            ExampleSentenceDataModel(sentence: "Learning new languages opens up a world of opportunities"),
            ExampleSentenceDataModel(sentence: "He is planning to travel to Japan next year"),
            ExampleSentenceDataModel(sentence: "Artificial intelligence is transforming industries"),
            ExampleSentenceDataModel(sentence: "Eating a balanced diet is essential for good health"),
            ExampleSentenceDataModel(sentence: "Music brings people together")
        ]
    }
}


