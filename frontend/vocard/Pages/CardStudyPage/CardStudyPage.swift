//
//  MainPage_CardStudyView.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI
import SwiftData

struct CardStudyPage: View {
    @State private var cardStudyPageViewModel: CardStudyPageViewModel = CardStudyPageViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .geometryGroup()
                .ignoresSafeArea()

            VStack {
                CardStudyPage_Top()
                    .padding(.horizontal)
                CardStudyPage_Middle()
                    .padding()
                CardStudyPage_Bottom()
                    .padding(.horizontal)
                    .controlSize(.extraLarge)


            }
            .environment(cardStudyPageViewModel)
        }
    }
}




#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
        .background(.black)
}
