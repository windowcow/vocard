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
            Button {
                isCardsPagePresented.toggle()

            } label: {
                Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled")
                    .font(.title)
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
