//
//  MainPage_NextCard.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI
import SwiftData


struct MainPage_Bottom_NextWord: View {
    @Namespace var namespace
    @Binding var a: Int
    @Environment(CurrentCard.self) var currentCard
    @State private var isCardStudyPagePresented: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.buttonStart
                VStack {
                    Spacer()
                    Spacer()
                    
                    Text(currentCard.currentCard?.targetWordDataModel.headWord ?? "No more card")
                        .foregroundStyle(.black)
                        .bold()
                        .font(.system(size: 48))
                        .matchedGeometryEffect(id: "text", in: namespace)

                    
                    Spacer()
                    Spacer()

                    Button{
                        isCardStudyPagePresented.toggle()
                    } label: {
                        Text("시작하기")
                            .frame(width: geo.size.width * 0.8,
                                   height: geo.size.height * 0.1)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .fullScreenCover(isPresented: $isCardStudyPagePresented) {
                        CardStudyPage()
                    }
                    
                    Spacer()

                }
            }
            .clipShape(.rect(cornerRadius: 10)) 
        }
        /// geo end
        
    }
}

#Preview {
    MainPage()
        .modelContainer(sharedModelContainer)
}
