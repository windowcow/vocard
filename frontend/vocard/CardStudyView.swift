//
//  ContentView.swift
//  vocard
//
//  Created by windowcow on 10/20/23.
//

import SwiftUI
import SwiftData


struct CardStudyViewTop: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("TODAY'S WORD")
                    .font(.title2)
                Text("128")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            .fixedSize(horizontal: false,
                       vertical: true)
            Spacer()
            Button(action: {}){
                Text("MENU")
                    .padding([.horizontal])
                    .padding([.vertical], 8)
                    .foregroundStyle(.black)
                    .background(.white, in: .rect(cornerRadius: 20))
            }
        }
    }
    
}

struct CardStudyView: View {
    var body: some View {
        VStack {
            
            CardStudyViewTop()
                .padding(.horizontal)
                .foregroundStyle(.white)
            
            Divider()
                .background(.white)
            Spacer()
            
            CardView()
                .padding()
        }
        .background(.black)

    }
}

#Preview {
    CardStudyView()
}
