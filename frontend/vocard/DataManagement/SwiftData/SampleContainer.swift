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
        
        let sampleQuizs = QuizDataModel.quizs
        sampleQuizs.forEach { sampleQuiz in
            container.mainContext.insert(sampleQuiz)
        }
        
        for i in 0...3 {
            CardDataModel.card[i].quizes.append(sampleQuizs[i])
            container.mainContext.insert(CardDataModel.card[i])

        }
        
        let userSettingsDataModel = UserSettingsDataModel(undealtCardAppearProbability: 50)
//        container.mainContext.insert(userSettingsDataModel)
        container.mainContext.insert(DeckDataModel(userSettingDataModel: userSettingsDataModel))
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()

