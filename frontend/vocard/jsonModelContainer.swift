//
//  JSonModelContainer.swift
//  vocard
//
//  Created by windowcow on 12/7/23.
//

import Foundation
import SwiftData

@MainActor
var realContainer: ModelContainer {
    let schema = Schema([
        CardData.self,
        ReviewData.self,
        WordData.self,
        MeaningData.self,
        ExampleData.self,
        IllustrationData.self,
        QuizData.self
        
    ])
    let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: modelConfiguration)
        
        var cards: [CardData] = []
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            fatalError()
        }
        
        if let vocabularyData = decodeWords(from: try! String(contentsOf: url)) {
            for (key, value) in vocabularyData {

                for senseNum in 1...value.dfnCnt {
                    var meaning = value.meaning[senseNum - 1]
                    var example = value.example[senseNum - 1]
                    var imageURL = value.imgUrl[senseNum - 1]
                    var korean = value.krWord[senseNum - 1]
                    var pos = value.pos[senseNum - 1]
                    
                    var quiz = value.quiz[senseNum - 1]
                    
                    var W = WordData()
                    var M = MeaningData(meaningNum: 1, meaning: meaning)
                    var E = ExampleData(sentence: example)
                    var I = IllustrationData(imageStyle: "", imageURL: URL(string: imageURL)!)
                    
                    let answer = switch quiz.correctAnswer {
                    case "A": 1
                    case "B": 2
                    case "C": 3
                    case "D": 4
                    default: 1
                    }
                    var Q = QuizData(question: quiz.question, choices: quiz.choices.map{$0.text}, answer: answer)
                    E.illustrations = [I]
                    E.sentence = example
                    
                    M.exampleSentences.append(E)
                    M.meaningInOtherLanguages = ["Korean": korean]
                    
                    W.headword = key
                    W.senseNum = senseNum
                    W.meaningDatas.append(M)
                    W.quizzes.append(Q)

                    W.pos = pos
                    
                    let card = CardData(targetWordDataModel: W)
                    
                    cards.append(card)

                }
                
            }
        }
        
        for card in cards {
            container.mainContext.insert(card)
            let a = (0...4).randomElement()!
            for _ in 0...a {
                let reviewData = ReviewData(reviewDate: Date.now.randomPastDate(7.day), result: .success(1))
                reviewData.cardDataModel = card
                card.reviewData.append(reviewData)
            }
        }
        
        
        
        
        
        
        return container
    } catch {
        fatalError()
    }
}

@MainActor
var cards: [CardData] {
    var cardData: [CardData] = []
    guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
        fatalError()
    }
    
    if let vocabularyData = decodeWords(from: try! String(contentsOf: url)) {
        for (key, value) in vocabularyData {

            for senseNum in 1...value.dfnCnt {
                var meaning = value.meaning[senseNum - 1]
                var example = value.example[senseNum - 1]
                var imageURL = value.example[senseNum - 1]
                var korean = value.krWord[senseNum - 1]
                var pos = value.pos[senseNum - 1]
                
                var quiz = value.quiz[senseNum - 1]
                
                var W = WordData()
                var M = MeaningData(meaningNum: 1, meaning: meaning)
                var E = ExampleData(sentence: example)
                var I = IllustrationData(imageStyle: "", imageURL: URL(string: imageURL)!)
                let answer = switch quiz.correctAnswer {
                case "A": 1
                case "B": 2
                case "C": 3
                case "D": 4
                default: 1
                }
                var Q = QuizData(question: quiz.question, choices: quiz.choices.map{$0.text}, answer: answer)
                E.illustrations = [I]
                E.sentence = example
                E.meaningData = M
                
                M.exampleSentences = [E]
                M.meaning = meaning
                M.meaningNum = 1
                M.wordData = W
                M.meaningInOtherLanguages = ["Korean": korean]
                
                W.headword = key
                W.senseNum = senseNum
                W.meaningDatas = [M]
                W.quizzes = [Q]
                W.pos = pos
                
                var card = CardData(targetWordDataModel: W)
                cardData.append(card)

            }
            
        }
        return cardData
    } else {
        return [CardData(targetWordDataModel: WordData())]
    }
}
struct Word: Codable {
    let pos: [String]
    let meaning: [String]
    let dfnCnt: Int
    var krWord: [String]
    let imgUrl: [String]
    let example: [String]
    let quiz: [Quiz]

    enum CodingKeys: String, CodingKey {
        case pos, meaning, example, quiz
        case dfnCnt = "dfn_cnt"
        case krWord = "kr_word"
        case imgUrl = "img_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pos = try container.decode([String].self, forKey: .pos)
        meaning = try container.decode([String].self, forKey: .meaning)
        dfnCnt = try container.decode(Int.self, forKey: .dfnCnt)
        imgUrl = try container.decode([String].self, forKey: .imgUrl)
        example = try container.decode([String].self, forKey: .example)
        quiz = try container.decode([Quiz].self, forKey: .quiz)

        // Handling krWord as either an array or a single string
        if let wordArray = try? container.decode([String].self, forKey: .krWord) {
            krWord = wordArray
        } else if let singleWord = try? container.decode(String.self, forKey: .krWord) {
            krWord = [singleWord]
        } else {
            krWord = []
        }
    }
}

struct Quiz: Codable {
    let question: String
    let choices: [Choice]
    let correctAnswer: String

    enum CodingKeys: String, CodingKey {
        case question, choices
        case correctAnswer = "correct_answer"
    }
}

struct Choice: Codable {
    let option: String
    let text: String
}

// Function to decode the JSON string into a dictionary of [String: Word]
func decodeWords(from jsonString: String) -> [String: Word]? {
    guard let jsonData = jsonString.data(using: .utf8) else {
        print("Error: Cannot create Data from JSON string")
        return nil
    }

    let decoder = JSONDecoder()
    do {
        let words = try decoder.decode([String: Word].self, from: jsonData)
        return words
    } catch {
        print("Error: \(error)")
        return nil
    }
}
