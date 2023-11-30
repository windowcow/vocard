//
//  SampleContainer.swift
//  vocard
//
//  Created by windowcow on 11/14/23.
//

import SwiftData

@MainActor
let sampleContainer: ModelContainer = {
    let schema = Schema([
        QuizDataModel.self, WordDataModel.self, UserSettingsDataModel.self, DeckDataModel.self, Deck.self, MaxHeap.self, ReviewResult.self
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    // if deploy : false

    do {
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        
//        let sampleQuizs = QuizDataModel.samples
//        sampleQuizs.forEach { sampleQuiz in
//            container.mainContext.insert(sampleQuiz)
//        }
//        
//        let deck: Deck = Deck(seenCardDeck: MaxHeap(elements: []), unseenCardDeck: [])
//        
//        
//        for i in 0...3 {
//            WordDataModel.card[i].quizzes.append(sampleQuizs[i])
////            container.mainContext.insert(WordDataModel.card[i])
//            container.mainContext.insert(WordDataModel.card[i])
//            deck.unseenCardDeck.append(WordDataModel.card[i])
//
//        }
//        
//        let userSettingsDataModel = UserSettingsDataModel(undealtCardAppearProbability: 50)
////        container.mainContext.insert(userSettingsDataModel)
//        container.mainContext.insert(DeckDataModel(userSettingDataModel: userSettingsDataModel))
//        
        let deck = Deck.sample
        container.mainContext.insert(deck)
        deck.changeCurrentCard(true) // true false 상관 x
        ReviewResult.samples.forEach { reviewResult in
            container.mainContext.insert(reviewResult)

        }

        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

