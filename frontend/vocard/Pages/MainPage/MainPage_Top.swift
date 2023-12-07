//
//  MainPage_Top.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI


struct MainPage_Top: View {
    @State private var isCardsPagePresented = false
    var body: some View {
        HStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
            Button("COLLECTION") {
                isCardsPagePresented.toggle()
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
            .fullScreenCover(isPresented: $isCardsPagePresented) {
                CardsPage()
            }


        }
        .padding(.horizontal)
        
    }
}

#Preview {
    RootView()
}
