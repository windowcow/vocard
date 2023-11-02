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
        GeometryReader { geo in
            VStack {
                CardStudyViewTop()
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                
                Divider()
                    .background(.white)
                
                Spacer()
                
                CardView()
                .frame(width: geo.size.width * 8 / 9 ,
                       height: geo.size.width * 11 / 7)
                
                CardViewBottom()
                
            }
            .background(.black)
        }
        

    }
}

#Preview {
    CardStudyView()
}
