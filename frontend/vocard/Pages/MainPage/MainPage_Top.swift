//
//  MainPage_Top.swift
//  SwiftDataPractice2
//
//  Created by windowcow on 12/2/23.
//

import SwiftUI


struct MainPage_Top: View {
    var body: some View {
        HStack {
            Image(.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button("My Page") {
                
            }
            Button("Alarm") {
                
            }
        }
        
    }
}

#Preview {
    RootView()
}