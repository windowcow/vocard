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
        QuizDataModel.self, CardDataModel.self, UserSettingsDataModel.self, DeckDataModel.self
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
    // if deploy : false

    do {
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        
        let sampleQuiz = QuizDataModel.quiz
        container.mainContext.insert(sampleQuiz)
        CardDataModel.card.forEach { card in
            let tempQuiz = QuizDataModel(backingData: sampleQuiz.persistentBackingData)
            container.mainContext.insert(tempQuiz)
            card.quizes.append(tempQuiz)
            container.mainContext.insert(card)
        }
        
        let userSettingsDataModel = UserSettingsDataModel(undealtCardAppearProbability: 50)
//        container.mainContext.insert(userSettingsDataModel)
        container.mainContext.insert(DeckDataModel(userSettingDataModel: userSettingsDataModel))
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

